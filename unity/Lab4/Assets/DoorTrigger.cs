using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Experimental.GlobalIllumination;

public class DoorTrigger : MonoBehaviour
{
    public GameObject cube1;
    public GameObject cube2;
    public GameObject propeller;
    public float openAngle = 90f;
    public float openSpeed = 2f;

    private void OnTriggerEnter(Collider col)
    {
        if (col.name == "player")
        {
            cube1.transform.Rotate(0, -openAngle, 0);
            cube2.transform.Rotate(0, openAngle, 0);
        }
    }

    private void OnTriggerExit(Collider col)
    {
        if (col.name == "player")
        {
            cube1.transform.Rotate(0, openAngle, 0);
            cube2.transform.Rotate(0, -openAngle, 0);
        }
    }
    private void OnTriggerStay(Collider col)
    {
        if (col.name == "robot")
        {
            propeller.transform.Translate(0.1f, 0f, 0.1f);
            propeller.transform.Rotate(0, 1, 0);
        }
    }
}
