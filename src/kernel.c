
#define GPIO_BASE     0x20200000UL
#define LED_GPFSEL    1
#define LED_GPFBIT    18
#define LED_GPCLR     10
#define LED_GPIO_BIT  16

int main(void) __attribute__((naked));
int main(void) {
  //Set GPIO address
  volatile unsigned int* gpio = (unsigned int*)GPIO_BASE;

  while(1){
    //Select the OK led
    gpio[LED_GPFSEL] = gpio[LED_GPFSEL] | (1 << LED_GPFBIT);
    //Turn it on
    gpio[LED_GPCLR] = (1 << LED_GPIO_BIT);
  }
}
