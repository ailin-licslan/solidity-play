// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

contract Merge2Array {
    function merge(uint[] memory a, uint[] memory b) public pure returns (uint[] memory) {

        //创建新数组，长度为a和b的长度之和
        uint[] memory c = new uint[](a.length + b.length);


        //双指针
        uint d = 0; // d数组的索引  额外指针d
        uint e = 0; // e数组的索引  额外指针e
        uint f = 0; // f数组的索引  待合并的新数组

        //合并两个数组，直到其中一个被完全遍历
        while (d < a.length && e < b.length) {
            if (a[d] < b[e]) {
                c[f] = a[d];
                d++;
            } else {
                c[f] = b[e];
                e++;
            }
            f++;
        }

        //将a数组剩余元素添加到c
        while (d < a.length) {
            c[f] = a[d];
            d++;
            f++;
        }

        //将b数组剩余元素添加到c
        while (e < b.length) {
            c[f] = b[e];
            e++;
            f++;
        }

        return c;
    }
}
