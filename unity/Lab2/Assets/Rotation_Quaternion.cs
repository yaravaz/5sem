using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Rotation_Quaternion : MonoBehaviour
{
    private Quaternion start;

    void Start()
    {
        start = transform.rotation;
    }

    void Update()
    {

        Quaternion rotationX = Quaternion.AngleAxis(2, Vector3.right);
        Quaternion rotationZ = Quaternion.AngleAxis(1, Vector3.forward);
        transform.rotation *= rotationX * rotationZ;

        /*Quaternion rotationGeneral = Quaternion.AngleAxis(1, new Vector3(2, 0, 1));
        transform.rotation *= rotationGeneral;*/
    }

}
