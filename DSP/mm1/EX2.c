#include <stdio.h>
#include <math.h>

int main() {
    const int sums = 100;
    const int iterations = 50;
    
    const int arrayLength = sums + iterations;    
    int samples[arrayLength];

    // Fill last (iterations) of places with one all othe as zero
    for (int i = 0; i < arrayLength; i++) {
        if (i < sums) 
            samples[i] = 0;
        else
            samples[i] = 1;
    }
        

    float a = 1.0f/8.0f;
    float b = 8.0f;
    for (int i = sums; i < arrayLength; i++) {
        float sumRes = 0.0f;

        for (int k = 0; k < iterations; k++) {        
            sumRes += exp((-k)/b) * samples[i - k];
        }

        float res = a * sumRes;
        printf("Res: [%d] = %f\n", i-sums, res);
    }

    return 0;
}