//Here are the sensor events

void onAccelerometerEvent(float x, float y, float z)
{
  accelerometer.set(x, y, z);
}

void onMagneticFieldEvent(float x, float y, float z, long time, int accuracy)
{
  magneticField.set(x, y, z);
}

void onRotationVectorEvent(float x, float y, float z)
{
  rotX = x;
  rotY = y;
  rotZ = z;
}

void onLightEvent(float v)
{
  light = v;
}

void onProximityEvent(float v)
{
  proximity = v;
}
