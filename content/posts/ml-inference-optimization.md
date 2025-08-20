---
title: "Optimizing ML Inference Latency: From Milliseconds to Microseconds"
date: 2025-08-20T11:00:00Z
draft: false
tags: ["inference-optimization", "latency", "performance", "machine-learning", "systems"]
categories: ["ai", "performance", "technical"]
author: "Yashash Gaurav"
showToc: true
TocOpen: true
hidemeta: false
comments: false
description: "Practical strategies for optimizing machine learning inference latency in production systems"
canonicalURL: ""
disableShare: false
disableHLJS: false
hideSummary: false
searchHidden: false
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true
cover:
    image: ""
    alt: "ML Inference Optimization"
    caption: "Strategies for faster ML inference"
    relative: false
    hidden: true
editPost:
    URL: "https://github.com/YashashGaurav/yashashgaurav.github.io/tree/main/content"
    Text: "Suggest Changes"
    appendFilePath: true
---

# The Need for Speed in ML Inference

In production ML systems, latency isn't just a nice-to-have—it's often the difference between a usable product and an abandoned one. At Ripple, where financial transactions happen in real-time, every millisecond counts. Here's what I've learned about optimizing ML inference latency from research to production.

## Understanding the Latency Landscape

### The Anatomy of Inference Latency

```python
import time
from functools import wraps

def measure_latency(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        start = time.perf_counter()
        result = func(*args, **kwargs)
        end = time.perf_counter()
        latency_ms = (end - start) * 1000
        print(f"{func.__name__}: {latency_ms:.2f}ms")
        return result
    return wrapper

@measure_latency
def full_inference_pipeline(input_data):
    # 1. Preprocessing
    processed_data = preprocess(input_data)
    
    # 2. Model inference
    predictions = model.predict(processed_data)
    
    # 3. Postprocessing
    results = postprocess(predictions)
    
    return results
```

**Typical latency breakdown:**
- **Preprocessing**: 10-30% of total time
- **Model inference**: 40-70% of total time  
- **Postprocessing**: 5-20% of total time
- **Network/IO**: 10-40% of total time

## Model-Level Optimizations

### 1. Model Architecture Choices

**Efficient Architectures:**
```python
# Example: Choosing efficient transformer variants
import torch
import torch.nn as nn

# Standard Transformer (slower)
class StandardTransformer(nn.Module):
    def __init__(self, d_model=512, nhead=8, num_layers=6):
        super().__init__()
        self.transformer = nn.Transformer(
            d_model=d_model,
            nhead=nhead,
            num_encoder_layers=num_layers,
            num_decoder_layers=num_layers
        )
    
# Optimized variant (faster)
class EfficientTransformer(nn.Module):
    def __init__(self, d_model=256, nhead=4, num_layers=3):
        super().__init__()
        # Smaller model with strategic layer reduction
        self.transformer = nn.Transformer(
            d_model=d_model,
            nhead=nhead,
            num_encoder_layers=num_layers,
            num_decoder_layers=num_layers
        )
```

### 2. Quantization Strategies

**Post-Training Quantization:**
```python
import torch.quantization as quant

def quantize_model(model, example_input):
    # Prepare model for quantization
    model.eval()
    model.qconfig = quant.get_default_qconfig('fbgemm')
    model_prepared = quant.prepare(model)
    
    # Calibrate with example data
    with torch.no_grad():
        model_prepared(example_input)
    
    # Convert to quantized model
    quantized_model = quant.convert(model_prepared)
    
    return quantized_model

# Typical results: 4x smaller model, 2-4x faster inference
```

**Quantization-Aware Training:**
```python
def setup_qat(model):
    model.train()
    model.qconfig = quant.get_default_qat_qconfig('fbgemm')
    model_prepared = quant.prepare_qat(model)
    
    return model_prepared

# Train with quantization simulation
def train_with_qat(model, dataloader):
    model = setup_qat(model)
    
    for epoch in range(num_epochs):
        for batch in dataloader:
            # Normal training loop
            loss = compute_loss(model(batch.x), batch.y)
            loss.backward()
            optimizer.step()
    
    # Convert to quantized for inference
    quantized_model = quant.convert(model.eval())
    return quantized_model
```

### 3. Model Pruning

**Structured Pruning:**
```python
import torch.nn.utils.prune as prune

def prune_model(model, pruning_ratio=0.3):
    # Prune entire channels/filters
    for name, module in model.named_modules():
        if isinstance(module, torch.nn.Conv2d):
            prune.random_structured(
                module, 
                name='weight', 
                amount=pruning_ratio, 
                dim=0  # Prune output channels
            )
        elif isinstance(module, torch.nn.Linear):
            prune.random_unstructured(
                module, 
                name='weight', 
                amount=pruning_ratio
            )
    
    return model
```

**Gradual Magnitude Pruning:**
```python
class GradualPruningScheduler:
    def __init__(self, initial_sparsity=0.0, final_sparsity=0.9, 
                 pruning_steps=1000):
        self.initial_sparsity = initial_sparsity
        self.final_sparsity = final_sparsity
        self.pruning_steps = pruning_steps
        self.current_step = 0
    
    def get_current_sparsity(self):
        if self.current_step >= self.pruning_steps:
            return self.final_sparsity
        
        # Polynomial decay
        progress = self.current_step / self.pruning_steps
        sparsity = self.initial_sparsity + (
            self.final_sparsity - self.initial_sparsity
        ) * (1 - (1 - progress) ** 3)
        
        return sparsity
    
    def step(self):
        self.current_step += 1
```

## System-Level Optimizations

### 1. Batching Strategies

**Dynamic Batching:**
```python
import asyncio
from collections import deque
import time

class DynamicBatcher:
    def __init__(self, max_batch_size=32, max_wait_time_ms=10):
        self.max_batch_size = max_batch_size
        self.max_wait_time_ms = max_wait_time_ms
        self.pending_requests = deque()
        self.batch_ready = asyncio.Event()
    
    async def add_request(self, request):
        future = asyncio.Future()
        self.pending_requests.append((request, future, time.time()))
        
        # Trigger batch processing if conditions met
        if (len(self.pending_requests) >= self.max_batch_size or 
            self._oldest_request_expired()):
            self.batch_ready.set()
        
        return await future
    
    async def process_batches(self):
        while True:
            await self.batch_ready.wait()
            
            if self.pending_requests:
                batch = self._create_batch()
                results = await self._process_batch(batch)
                self._return_results(batch, results)
            
            self.batch_ready.clear()
    
    def _create_batch(self):
        batch_size = min(len(self.pending_requests), self.max_batch_size)
        batch = []
        
        for _ in range(batch_size):
            batch.append(self.pending_requests.popleft())
        
        return batch
```

### 2. Model Serving Optimizations

**ONNX Runtime Optimization:**
```python
import onnxruntime as ort

def optimize_onnx_model(model_path):
    # Set optimization level
    sess_options = ort.SessionOptions()
    sess_options.graph_optimization_level = (
        ort.GraphOptimizationLevel.ORT_ENABLE_ALL
    )
    
    # Enable parallelism
    sess_options.intra_op_num_threads = 4
    sess_options.inter_op_num_threads = 2
    
    # Use specific providers
    providers = [
        ('CUDAExecutionProvider', {
            'device_id': 0,
            'arena_extend_strategy': 'kNextPowerOfTwo',
            'gpu_mem_limit': 2 * 1024 * 1024 * 1024,  # 2GB
        }),
        'CPUExecutionProvider'
    ]
    
    session = ort.InferenceSession(
        model_path, 
        sess_options=sess_options,
        providers=providers
    )
    
    return session

# Typical speedup: 2-5x over PyTorch
```

**TensorRT Optimization:**
```python
import tensorrt as trt

def build_tensorrt_engine(onnx_model_path, max_batch_size=32):
    logger = trt.Logger(trt.Logger.WARNING)
    builder = trt.Builder(logger)
    network = builder.create_network(
        1 << int(trt.NetworkDefinitionCreationFlag.EXPLICIT_BATCH)
    )
    
    parser = trt.OnnxParser(network, logger)
    parser.parse_from_file(onnx_model_path)
    
    config = builder.create_builder_config()
    config.max_workspace_size = 1 << 30  # 1GB
    
    # Enable FP16 precision
    if builder.platform_has_fast_fp16:
        config.set_flag(trt.BuilderFlag.FP16)
    
    # Build engine
    engine = builder.build_engine(network, config)
    
    return engine

# Typical speedup: 5-10x over PyTorch on GPU
```

### 3. Memory Optimization

**Memory Pool Management:**
```python
import torch

class MemoryPool:
    def __init__(self, initial_size_mb=100):
        self.pool_size = initial_size_mb * 1024 * 1024
        self.allocated_tensors = []
        self.free_tensors = []
        
        # Pre-allocate memory pool
        torch.cuda.empty_cache()
        self._warmup_pool()
    
    def get_tensor(self, shape, dtype=torch.float32):
        # Try to reuse existing tensor
        for i, tensor in enumerate(self.free_tensors):
            if (tensor.shape == shape and 
                tensor.dtype == dtype):
                return self.free_tensors.pop(i)
        
        # Allocate new tensor
        tensor = torch.empty(shape, dtype=dtype, device='cuda')
        self.allocated_tensors.append(tensor)
        return tensor
    
    def return_tensor(self, tensor):
        # Reset tensor and return to pool
        tensor.zero_()
        self.free_tensors.append(tensor)
    
    def _warmup_pool(self):
        # Pre-allocate common tensor sizes
        common_shapes = [
            (1, 768), (32, 768), (1, 512), (32, 512)
        ]
        
        for shape in common_shapes:
            for _ in range(5):  # 5 tensors per shape
                tensor = torch.empty(shape, device='cuda')
                self.free_tensors.append(tensor)
```

## Advanced Optimization Techniques

### 1. Knowledge Distillation

**Teacher-Student Training:**
```python
import torch.nn.functional as F

class DistillationLoss(nn.Module):
    def __init__(self, temperature=3.0, alpha=0.7):
        super().__init__()
        self.temperature = temperature
        self.alpha = alpha
    
    def forward(self, student_logits, teacher_logits, true_labels):
        # Soft targets from teacher
        soft_targets = F.softmax(teacher_logits / self.temperature, dim=1)
        soft_student = F.log_softmax(student_logits / self.temperature, dim=1)
        
        # Distillation loss
        distillation_loss = F.kl_div(
            soft_student, soft_targets, reduction='batchmean'
        ) * (self.temperature ** 2)
        
        # Standard cross-entropy loss
        student_loss = F.cross_entropy(student_logits, true_labels)
        
        # Combined loss
        total_loss = (
            self.alpha * distillation_loss + 
            (1 - self.alpha) * student_loss
        )
        
        return total_loss

# Typical result: 10-50x smaller model with 95%+ performance retention
```

### 2. Early Exit Networks

**Adaptive Computation:**
```python
class EarlyExitClassifier(nn.Module):
    def __init__(self, base_model, num_classes, exit_thresholds):
        super().__init__()
        self.base_model = base_model
        self.exit_thresholds = exit_thresholds
        self.exit_classifiers = nn.ModuleList([
            nn.Linear(hidden_size, num_classes) 
            for hidden_size in base_model.hidden_sizes
        ])
    
    def forward(self, x, use_early_exit=True):
        outputs = []
        
        for i, layer in enumerate(self.base_model.layers):
            x = layer(x)
            
            if use_early_exit and i < len(self.exit_classifiers):
                # Compute exit prediction
                exit_logits = self.exit_classifiers[i](x)
                exit_confidence = torch.max(F.softmax(exit_logits, dim=1), dim=1)[0]
                
                # Check if confident enough to exit early
                if torch.mean(exit_confidence) > self.exit_thresholds[i]:
                    return exit_logits
                
                outputs.append(exit_logits)
        
        # Final layer output
        final_logits = self.base_model.final_layer(x)
        return final_logits

# Adaptive inference: Fast predictions for easy cases, 
# full computation for hard cases
```

### 3. Caching Strategies

**Multi-Level Caching:**
```python
from functools import lru_cache
import hashlib
import redis

class MLCache:
    def __init__(self, redis_client=None, max_memory_items=1000):
        self.redis = redis_client
        self.memory_cache = {}
        self.max_memory_items = max_memory_items
    
    def _hash_input(self, input_data):
        # Create stable hash of input
        if isinstance(input_data, torch.Tensor):
            input_bytes = input_data.cpu().numpy().tobytes()
        else:
            input_bytes = str(input_data).encode()
        
        return hashlib.md5(input_bytes).hexdigest()
    
    def get(self, input_data):
        cache_key = self._hash_input(input_data)
        
        # Check memory cache first (fastest)
        if cache_key in self.memory_cache:
            return self.memory_cache[cache_key]
        
        # Check Redis cache (fast)
        if self.redis:
            cached_result = self.redis.get(cache_key)
            if cached_result:
                result = pickle.loads(cached_result)
                # Promote to memory cache
                self._add_to_memory_cache(cache_key, result)
                return result
        
        return None
    
    def set(self, input_data, result, ttl_seconds=3600):
        cache_key = self._hash_input(input_data)
        
        # Store in memory cache
        self._add_to_memory_cache(cache_key, result)
        
        # Store in Redis cache
        if self.redis:
            self.redis.setex(
                cache_key, 
                ttl_seconds, 
                pickle.dumps(result)
            )
    
    def _add_to_memory_cache(self, key, value):
        if len(self.memory_cache) >= self.max_memory_items:
            # Remove oldest item (simple FIFO)
            oldest_key = next(iter(self.memory_cache))
            del self.memory_cache[oldest_key]
        
        self.memory_cache[key] = value
```

## Measuring and Monitoring Performance

### Comprehensive Latency Profiling

```python
import cProfile
import pstats
from contextlib import contextmanager

class LatencyProfiler:
    def __init__(self):
        self.measurements = {}
    
    @contextmanager
    def profile_section(self, section_name):
        start_time = time.perf_counter()
        
        # Memory usage before
        if torch.cuda.is_available():
            torch.cuda.synchronize()
            memory_before = torch.cuda.memory_allocated()
        
        try:
            yield
        finally:
            # Memory usage after
            if torch.cuda.is_available():
                torch.cuda.synchronize()
                memory_after = torch.cuda.memory_allocated()
                memory_delta = memory_after - memory_before
            else:
                memory_delta = 0
            
            end_time = time.perf_counter()
            latency = (end_time - start_time) * 1000  # milliseconds
            
            if section_name not in self.measurements:
                self.measurements[section_name] = []
            
            self.measurements[section_name].append({
                'latency_ms': latency,
                'memory_delta_bytes': memory_delta
            })
    
    def get_stats(self):
        stats = {}
        for section, measurements in self.measurements.items():
            latencies = [m['latency_ms'] for m in measurements]
            memory_deltas = [m['memory_delta_bytes'] for m in measurements]
            
            stats[section] = {
                'avg_latency_ms': np.mean(latencies),
                'p95_latency_ms': np.percentile(latencies, 95),
                'p99_latency_ms': np.percentile(latencies, 99),
                'avg_memory_delta_mb': np.mean(memory_deltas) / (1024**2)
            }
        
        return stats

# Usage
profiler = LatencyProfiler()

with profiler.profile_section('preprocessing'):
    processed_data = preprocess(input_data)

with profiler.profile_section('inference'):
    predictions = model(processed_data)

with profiler.profile_section('postprocessing'):
    results = postprocess(predictions)

print(profiler.get_stats())
```

## Real-World Results and Trade-offs

From my experience optimizing production ML systems:

### Optimization Impact Table

| Technique | Latency Improvement | Model Size Reduction | Accuracy Impact |
|-----------|-------------------|---------------------|-----------------|
| Quantization (INT8) | 2-4x | 4x | <1% |
| Pruning (70% sparse) | 1.5-2x | 3x | 1-3% |
| Knowledge Distillation | 5-10x | 10-50x | 2-5% |
| TensorRT Optimization | 3-7x | - | <1% |
| ONNX Runtime | 2-3x | - | 0% |
| Batching | 2-5x | - | 0% |

### The Optimization Hierarchy

1. **Start with profiling** - Understand your bottlenecks
2. **Model-level optimizations** - Quantization, pruning, distillation
3. **System-level optimizations** - Batching, caching, serving framework
4. **Hardware-specific optimizations** - TensorRT, specialized chips
5. **Algorithmic optimizations** - Early exit, adaptive computation

## Conclusion

Optimizing ML inference latency is both an art and a science. The key lessons I've learned:

1. **Profile first, optimize second** - Don't guess where the bottlenecks are
2. **Consider the full system** - Model optimization is just one piece
3. **Measure accuracy-latency trade-offs** - Not all optimizations are worth it
4. **Think about your specific use case** - Batch vs. online, GPU vs. CPU, etc.
5. **Iterate and monitor** - Performance characteristics change over time

The field is rapidly evolving, with new techniques like neural architecture search for efficient models and hardware-aware optimization becoming more prevalent. The key is to build a systematic approach to measurement and optimization that you can apply as new techniques emerge.

---

*What latency optimization challenges are you facing? I'd love to discuss specific use cases and share more targeted strategies. Reach out on [Twitter](https://twitter.com/yashashgaurav) or [LinkedIn](https://linkedin.com/in/yashashgaurav).*
