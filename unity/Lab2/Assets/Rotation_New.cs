using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Rotation_New : MonoBehaviour
{
    private float angle;
    private Vector3 os;

    void Start()
    {
        angle = 0f;
        os = new Vector3(3, 2, 1).normalized;
    }

    void Update()
    {
        angle += Time.deltaTime * 300f;
        Quaternion rotation = Quaternion.AngleAxis(angle, os);
        transform.rotation = rotation;
    }
}
