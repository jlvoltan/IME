#include <Servo.h>
#include <Ultrasonic.h>

Servo myservo[6];
int pino_trigger[] = {3, 7};
int pino_echo[] = {5, 9};
int angles[] = {90, 90, 160, 90, 0, 160};
Ultrasonic ultrasonic1(pino_trigger[0], pino_echo[0]);
Ultrasonic ultrasonic2(pino_trigger[1], pino_echo[1]);

int move_servo(int servo_id, int end_angle){
  int start_angle = angles[servo_id];
  if(start_angle < end_angle){
    for(int angle=start_angle; angle <= end_angle; angle++){
      myservo[servo_id].write(angle);
      delay(40);
    }
  }
  else{
    for(int angle=start_angle; angle >= end_angle; angle--){
      myservo[servo_id].write(angle);
      delay(40);
    }
  }
  angles[servo_id] = end_angle;
}

void angular_cycle(int servo_id, int min_angle, int max_angle){
  move_servo(servo_id, min_angle);
  move_servo(servo_id, max_angle);
  move_servo(servo_id, min_angle);
}

void setup() {
  Serial.begin(9600);
  for(int i=0; i<6; i++){
    myservo[i].attach((i+1)*2);
    myservo[i].write(angles[i]);
  }
}

void loop() {

  float cmMsec[2];
  long microsec[] = {ultrasonic1.timing(), ultrasonic2.timing()};
  cmMsec[0] = ultrasonic1.convert(microsec[0], Ultrasonic::CM);
  cmMsec[1] = ultrasonic1.convert(microsec[1], Ultrasonic::CM);
  
  Serial.print("Distancia em cm: \n");
  for(int i=0; i<2; i++){
    Serial.print(i);
    Serial.print(": ");
    Serial.print(cmMsec[i]);
    Serial.print("\n");
  }

  float threshold = 10;
  if(cmMsec[0] < threshold){
    move_servo(0, 0);
    angular_cycle(2, 160, 170);
  }
  else if(cmMsec[1] < threshold){
    move_servo(0, 180);
    angular_cycle(2, 160, 170);
  }
  else{
    move_servo(0, 90);
  }
  delay(1000);
}
