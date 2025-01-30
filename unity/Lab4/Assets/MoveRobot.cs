using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MoveRobot : MonoBehaviour
{
    public float moveSpeed = 0.1f;

    void Start()
    {

    }

    void Update()
    {
        float moveHorizontal = 0f;
        float moveVertical = 0f;

        if (Input.GetKey(KeyCode.E))
        {
            moveHorizontal = -1f;
        }
        else if (Input.GetKey(KeyCode.R))
        {
            moveVertical = 1f;
        }

        if (Input.GetKey(KeyCode.T))
        {
            moveVertical = -1f;
        }
        else if (Input.GetKey(KeyCode.Y))
        {
            moveHorizontal = 1f;
        }

        Vector3 movement = new Vector3(moveHorizontal, 0f, moveVertical) * moveSpeed * Time.deltaTime;
        transform.Translate(movement);

        float mouseX = Input.GetAxis("Mouse X");
        Vector3 rotation = new Vector3(0f, mouseX, 0f) * moveSpeed;
        transform.Rotate(rotation);

    }
}
