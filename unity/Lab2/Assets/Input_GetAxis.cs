using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Input_GetAxis : MonoBehaviour
{
    private float rotAroundX = 0f;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        float hor = Input.GetAxis("Horizontal");
        float ver = Input.GetAxis("Vertical");

        transform.Translate(hor, 0, ver);

        float mouseX = Input.GetAxis("Mouse X");
        float mouseY = Input.GetAxis("Mouse Y");

        rotAroundX -= mouseY * 2;
        rotAroundX = Mathf.Clamp(rotAroundX, 0f, 90f);

        transform.Rotate(0, mouseX * 2, 0);
        transform.localRotation = Quaternion.Euler(rotAroundX, transform.localEulerAngles.y, 0);
    }
}
