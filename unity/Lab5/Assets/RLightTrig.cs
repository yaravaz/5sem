using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RLightTrig : MonoBehaviour
{
    public Light point; 

    void OnTriggerEnter(Collider col)
    {
        if (col.name == "corpus")
        {
            point.intensity = 10;
        }
    }

    void OnTriggerExit(Collider col)
    {
        if (col.name == "corpus")
        {
            point.intensity = 0;
        }
    }
}
