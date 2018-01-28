package com.read;

import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.LineIterator;

public class ReadFile {

	public static LineIterator getFileIterator(String fileName) {
		File file = new File(fileName);
		LineIterator it = null;
		try {
			it = FileUtils.lineIterator(file, "UTF-8");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return it;

	}

	public static void printFile(String fileName) {
		File file = new File(fileName);
		LineIterator it;
		try {
			it = FileUtils.lineIterator(file, "UTF-8");

			try {
				while (it.hasNext()) {
					String line = it.nextLine();
					// do something with line
					System.out.println(line);
				}
			} finally {
				it.close();
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		printFile(args[0]);
	}

}
