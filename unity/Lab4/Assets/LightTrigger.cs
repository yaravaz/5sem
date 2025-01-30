using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LightTrigger : MonoBehaviour
{
    public GameObject Cylinder;
    public Light point1;
    public Light point2;
    public Light point3;
    private void OnTriggerStay(Collider col)
    {
        if(col.name == "player")
        {
            Cylinder.transform.Rotate(0, 10, 0);
            if (point1.intensity < 50) point1.intensity += 1f;
            else point1.intensity = 0;
            if (point2.intensity < 50) point2.intensity += 1f;
            else point2.intensity = 0;
            if (point3.intensity < 50) point3.intensity += 1f;
            else point3.intensity = 0;
        }
    }
}
