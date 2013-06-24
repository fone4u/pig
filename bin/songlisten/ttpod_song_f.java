// ORM class for table 'ttpod_song_f'
// WARNING: This class is AUTO-GENERATED. Modify at your own risk.
//
// Debug information:
// Generated date: Sun Jun 09 15:29:21 CST 2013
// For connector: org.apache.sqoop.manager.MySQLManager
import org.apache.hadoop.io.BytesWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.io.Writable;
import org.apache.hadoop.mapred.lib.db.DBWritable;
import com.cloudera.sqoop.lib.JdbcWritableBridge;
import com.cloudera.sqoop.lib.DelimiterSet;
import com.cloudera.sqoop.lib.FieldFormatter;
import com.cloudera.sqoop.lib.RecordParser;
import com.cloudera.sqoop.lib.BooleanParser;
import com.cloudera.sqoop.lib.BlobRef;
import com.cloudera.sqoop.lib.ClobRef;
import com.cloudera.sqoop.lib.LargeObjectLoader;
import com.cloudera.sqoop.lib.SqoopRecord;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.io.DataInput;
import java.io.DataOutput;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

public class ttpod_song_f extends SqoopRecord  implements DBWritable, Writable {
  private final int PROTOCOL_VERSION = 3;
  public int getClassFormatVersion() { return PROTOCOL_VERSION; }
  protected ResultSet __cur_result_set;
  private String f;
  public String get_f() {
    return f;
  }
  public void set_f(String f) {
    this.f = f;
  }
  public ttpod_song_f with_f(String f) {
    this.f = f;
    return this;
  }
  private Integer uids;
  public Integer get_uids() {
    return uids;
  }
  public void set_uids(Integer uids) {
    this.uids = uids;
  }
  public ttpod_song_f with_uids(Integer uids) {
    this.uids = uids;
    return this;
  }
  private Integer songs;
  public Integer get_songs() {
    return songs;
  }
  public void set_songs(Integer songs) {
    this.songs = songs;
  }
  public ttpod_song_f with_songs(Integer songs) {
    this.songs = songs;
    return this;
  }
  private Integer lis_01;
  public Integer get_lis_01() {
    return lis_01;
  }
  public void set_lis_01(Integer lis_01) {
    this.lis_01 = lis_01;
  }
  public ttpod_song_f with_lis_01(Integer lis_01) {
    this.lis_01 = lis_01;
    return this;
  }
  private Integer lis_02;
  public Integer get_lis_02() {
    return lis_02;
  }
  public void set_lis_02(Integer lis_02) {
    this.lis_02 = lis_02;
  }
  public ttpod_song_f with_lis_02(Integer lis_02) {
    this.lis_02 = lis_02;
    return this;
  }
  private Integer lis_03;
  public Integer get_lis_03() {
    return lis_03;
  }
  public void set_lis_03(Integer lis_03) {
    this.lis_03 = lis_03;
  }
  public ttpod_song_f with_lis_03(Integer lis_03) {
    this.lis_03 = lis_03;
    return this;
  }
  private Integer lis_04;
  public Integer get_lis_04() {
    return lis_04;
  }
  public void set_lis_04(Integer lis_04) {
    this.lis_04 = lis_04;
  }
  public ttpod_song_f with_lis_04(Integer lis_04) {
    this.lis_04 = lis_04;
    return this;
  }
  private Integer lis_05;
  public Integer get_lis_05() {
    return lis_05;
  }
  public void set_lis_05(Integer lis_05) {
    this.lis_05 = lis_05;
  }
  public ttpod_song_f with_lis_05(Integer lis_05) {
    this.lis_05 = lis_05;
    return this;
  }
  private Integer lis_06;
  public Integer get_lis_06() {
    return lis_06;
  }
  public void set_lis_06(Integer lis_06) {
    this.lis_06 = lis_06;
  }
  public ttpod_song_f with_lis_06(Integer lis_06) {
    this.lis_06 = lis_06;
    return this;
  }
  private Integer lis_07;
  public Integer get_lis_07() {
    return lis_07;
  }
  public void set_lis_07(Integer lis_07) {
    this.lis_07 = lis_07;
  }
  public ttpod_song_f with_lis_07(Integer lis_07) {
    this.lis_07 = lis_07;
    return this;
  }
  private Integer lis_08;
  public Integer get_lis_08() {
    return lis_08;
  }
  public void set_lis_08(Integer lis_08) {
    this.lis_08 = lis_08;
  }
  public ttpod_song_f with_lis_08(Integer lis_08) {
    this.lis_08 = lis_08;
    return this;
  }
  private Integer lis_09;
  public Integer get_lis_09() {
    return lis_09;
  }
  public void set_lis_09(Integer lis_09) {
    this.lis_09 = lis_09;
  }
  public ttpod_song_f with_lis_09(Integer lis_09) {
    this.lis_09 = lis_09;
    return this;
  }
  private Integer lis_10;
  public Integer get_lis_10() {
    return lis_10;
  }
  public void set_lis_10(Integer lis_10) {
    this.lis_10 = lis_10;
  }
  public ttpod_song_f with_lis_10(Integer lis_10) {
    this.lis_10 = lis_10;
    return this;
  }
  private Integer lis_11;
  public Integer get_lis_11() {
    return lis_11;
  }
  public void set_lis_11(Integer lis_11) {
    this.lis_11 = lis_11;
  }
  public ttpod_song_f with_lis_11(Integer lis_11) {
    this.lis_11 = lis_11;
    return this;
  }
  private Integer lis_12;
  public Integer get_lis_12() {
    return lis_12;
  }
  public void set_lis_12(Integer lis_12) {
    this.lis_12 = lis_12;
  }
  public ttpod_song_f with_lis_12(Integer lis_12) {
    this.lis_12 = lis_12;
    return this;
  }
  private Integer lis_13;
  public Integer get_lis_13() {
    return lis_13;
  }
  public void set_lis_13(Integer lis_13) {
    this.lis_13 = lis_13;
  }
  public ttpod_song_f with_lis_13(Integer lis_13) {
    this.lis_13 = lis_13;
    return this;
  }
  private Integer lis_14;
  public Integer get_lis_14() {
    return lis_14;
  }
  public void set_lis_14(Integer lis_14) {
    this.lis_14 = lis_14;
  }
  public ttpod_song_f with_lis_14(Integer lis_14) {
    this.lis_14 = lis_14;
    return this;
  }
  private Integer lis_15;
  public Integer get_lis_15() {
    return lis_15;
  }
  public void set_lis_15(Integer lis_15) {
    this.lis_15 = lis_15;
  }
  public ttpod_song_f with_lis_15(Integer lis_15) {
    this.lis_15 = lis_15;
    return this;
  }
  private Integer lis_16_19;
  public Integer get_lis_16_19() {
    return lis_16_19;
  }
  public void set_lis_16_19(Integer lis_16_19) {
    this.lis_16_19 = lis_16_19;
  }
  public ttpod_song_f with_lis_16_19(Integer lis_16_19) {
    this.lis_16_19 = lis_16_19;
    return this;
  }
  private Integer lis_20_29;
  public Integer get_lis_20_29() {
    return lis_20_29;
  }
  public void set_lis_20_29(Integer lis_20_29) {
    this.lis_20_29 = lis_20_29;
  }
  public ttpod_song_f with_lis_20_29(Integer lis_20_29) {
    this.lis_20_29 = lis_20_29;
    return this;
  }
  private Integer lis_30_39;
  public Integer get_lis_30_39() {
    return lis_30_39;
  }
  public void set_lis_30_39(Integer lis_30_39) {
    this.lis_30_39 = lis_30_39;
  }
  public ttpod_song_f with_lis_30_39(Integer lis_30_39) {
    this.lis_30_39 = lis_30_39;
    return this;
  }
  private Integer lis_40;
  public Integer get_lis_40() {
    return lis_40;
  }
  public void set_lis_40(Integer lis_40) {
    this.lis_40 = lis_40;
  }
  public ttpod_song_f with_lis_40(Integer lis_40) {
    this.lis_40 = lis_40;
    return this;
  }
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof ttpod_song_f)) {
      return false;
    }
    ttpod_song_f that = (ttpod_song_f) o;
    boolean equal = true;
    equal = equal && (this.f == null ? that.f == null : this.f.equals(that.f));
    equal = equal && (this.uids == null ? that.uids == null : this.uids.equals(that.uids));
    equal = equal && (this.songs == null ? that.songs == null : this.songs.equals(that.songs));
    equal = equal && (this.lis_01 == null ? that.lis_01 == null : this.lis_01.equals(that.lis_01));
    equal = equal && (this.lis_02 == null ? that.lis_02 == null : this.lis_02.equals(that.lis_02));
    equal = equal && (this.lis_03 == null ? that.lis_03 == null : this.lis_03.equals(that.lis_03));
    equal = equal && (this.lis_04 == null ? that.lis_04 == null : this.lis_04.equals(that.lis_04));
    equal = equal && (this.lis_05 == null ? that.lis_05 == null : this.lis_05.equals(that.lis_05));
    equal = equal && (this.lis_06 == null ? that.lis_06 == null : this.lis_06.equals(that.lis_06));
    equal = equal && (this.lis_07 == null ? that.lis_07 == null : this.lis_07.equals(that.lis_07));
    equal = equal && (this.lis_08 == null ? that.lis_08 == null : this.lis_08.equals(that.lis_08));
    equal = equal && (this.lis_09 == null ? that.lis_09 == null : this.lis_09.equals(that.lis_09));
    equal = equal && (this.lis_10 == null ? that.lis_10 == null : this.lis_10.equals(that.lis_10));
    equal = equal && (this.lis_11 == null ? that.lis_11 == null : this.lis_11.equals(that.lis_11));
    equal = equal && (this.lis_12 == null ? that.lis_12 == null : this.lis_12.equals(that.lis_12));
    equal = equal && (this.lis_13 == null ? that.lis_13 == null : this.lis_13.equals(that.lis_13));
    equal = equal && (this.lis_14 == null ? that.lis_14 == null : this.lis_14.equals(that.lis_14));
    equal = equal && (this.lis_15 == null ? that.lis_15 == null : this.lis_15.equals(that.lis_15));
    equal = equal && (this.lis_16_19 == null ? that.lis_16_19 == null : this.lis_16_19.equals(that.lis_16_19));
    equal = equal && (this.lis_20_29 == null ? that.lis_20_29 == null : this.lis_20_29.equals(that.lis_20_29));
    equal = equal && (this.lis_30_39 == null ? that.lis_30_39 == null : this.lis_30_39.equals(that.lis_30_39));
    equal = equal && (this.lis_40 == null ? that.lis_40 == null : this.lis_40.equals(that.lis_40));
    return equal;
  }
  public void readFields(ResultSet __dbResults) throws SQLException {
    this.__cur_result_set = __dbResults;
    this.f = JdbcWritableBridge.readString(1, __dbResults);
    this.uids = JdbcWritableBridge.readInteger(2, __dbResults);
    this.songs = JdbcWritableBridge.readInteger(3, __dbResults);
    this.lis_01 = JdbcWritableBridge.readInteger(4, __dbResults);
    this.lis_02 = JdbcWritableBridge.readInteger(5, __dbResults);
    this.lis_03 = JdbcWritableBridge.readInteger(6, __dbResults);
    this.lis_04 = JdbcWritableBridge.readInteger(7, __dbResults);
    this.lis_05 = JdbcWritableBridge.readInteger(8, __dbResults);
    this.lis_06 = JdbcWritableBridge.readInteger(9, __dbResults);
    this.lis_07 = JdbcWritableBridge.readInteger(10, __dbResults);
    this.lis_08 = JdbcWritableBridge.readInteger(11, __dbResults);
    this.lis_09 = JdbcWritableBridge.readInteger(12, __dbResults);
    this.lis_10 = JdbcWritableBridge.readInteger(13, __dbResults);
    this.lis_11 = JdbcWritableBridge.readInteger(14, __dbResults);
    this.lis_12 = JdbcWritableBridge.readInteger(15, __dbResults);
    this.lis_13 = JdbcWritableBridge.readInteger(16, __dbResults);
    this.lis_14 = JdbcWritableBridge.readInteger(17, __dbResults);
    this.lis_15 = JdbcWritableBridge.readInteger(18, __dbResults);
    this.lis_16_19 = JdbcWritableBridge.readInteger(19, __dbResults);
    this.lis_20_29 = JdbcWritableBridge.readInteger(20, __dbResults);
    this.lis_30_39 = JdbcWritableBridge.readInteger(21, __dbResults);
    this.lis_40 = JdbcWritableBridge.readInteger(22, __dbResults);
  }
  public void loadLargeObjects(LargeObjectLoader __loader)
      throws SQLException, IOException, InterruptedException {
  }
  public void write(PreparedStatement __dbStmt) throws SQLException {
    write(__dbStmt, 0);
  }

  public int write(PreparedStatement __dbStmt, int __off) throws SQLException {
    JdbcWritableBridge.writeString(f, 1 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeInteger(uids, 2 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(songs, 3 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(lis_01, 4 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(lis_02, 5 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(lis_03, 6 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(lis_04, 7 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(lis_05, 8 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(lis_06, 9 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(lis_07, 10 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(lis_08, 11 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(lis_09, 12 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(lis_10, 13 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(lis_11, 14 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(lis_12, 15 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(lis_13, 16 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(lis_14, 17 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(lis_15, 18 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(lis_16_19, 19 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(lis_20_29, 20 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(lis_30_39, 21 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(lis_40, 22 + __off, 4, __dbStmt);
    return 22;
  }
  public void readFields(DataInput __dataIn) throws IOException {
    if (__dataIn.readBoolean()) { 
        this.f = null;
    } else {
    this.f = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.uids = null;
    } else {
    this.uids = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.songs = null;
    } else {
    this.songs = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.lis_01 = null;
    } else {
    this.lis_01 = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.lis_02 = null;
    } else {
    this.lis_02 = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.lis_03 = null;
    } else {
    this.lis_03 = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.lis_04 = null;
    } else {
    this.lis_04 = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.lis_05 = null;
    } else {
    this.lis_05 = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.lis_06 = null;
    } else {
    this.lis_06 = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.lis_07 = null;
    } else {
    this.lis_07 = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.lis_08 = null;
    } else {
    this.lis_08 = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.lis_09 = null;
    } else {
    this.lis_09 = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.lis_10 = null;
    } else {
    this.lis_10 = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.lis_11 = null;
    } else {
    this.lis_11 = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.lis_12 = null;
    } else {
    this.lis_12 = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.lis_13 = null;
    } else {
    this.lis_13 = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.lis_14 = null;
    } else {
    this.lis_14 = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.lis_15 = null;
    } else {
    this.lis_15 = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.lis_16_19 = null;
    } else {
    this.lis_16_19 = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.lis_20_29 = null;
    } else {
    this.lis_20_29 = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.lis_30_39 = null;
    } else {
    this.lis_30_39 = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.lis_40 = null;
    } else {
    this.lis_40 = Integer.valueOf(__dataIn.readInt());
    }
  }
  public void write(DataOutput __dataOut) throws IOException {
    if (null == this.f) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, f);
    }
    if (null == this.uids) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.uids);
    }
    if (null == this.songs) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.songs);
    }
    if (null == this.lis_01) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.lis_01);
    }
    if (null == this.lis_02) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.lis_02);
    }
    if (null == this.lis_03) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.lis_03);
    }
    if (null == this.lis_04) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.lis_04);
    }
    if (null == this.lis_05) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.lis_05);
    }
    if (null == this.lis_06) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.lis_06);
    }
    if (null == this.lis_07) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.lis_07);
    }
    if (null == this.lis_08) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.lis_08);
    }
    if (null == this.lis_09) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.lis_09);
    }
    if (null == this.lis_10) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.lis_10);
    }
    if (null == this.lis_11) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.lis_11);
    }
    if (null == this.lis_12) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.lis_12);
    }
    if (null == this.lis_13) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.lis_13);
    }
    if (null == this.lis_14) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.lis_14);
    }
    if (null == this.lis_15) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.lis_15);
    }
    if (null == this.lis_16_19) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.lis_16_19);
    }
    if (null == this.lis_20_29) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.lis_20_29);
    }
    if (null == this.lis_30_39) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.lis_30_39);
    }
    if (null == this.lis_40) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.lis_40);
    }
  }
  private final DelimiterSet __outputDelimiters = new DelimiterSet((char) 44, (char) 10, (char) 0, (char) 0, false);
  public String toString() {
    return toString(__outputDelimiters, true);
  }
  public String toString(DelimiterSet delimiters) {
    return toString(delimiters, true);
  }
  public String toString(boolean useRecordDelim) {
    return toString(__outputDelimiters, useRecordDelim);
  }
  public String toString(DelimiterSet delimiters, boolean useRecordDelim) {
    StringBuilder __sb = new StringBuilder();
    char fieldDelim = delimiters.getFieldsTerminatedBy();
    __sb.append(FieldFormatter.escapeAndEnclose(f==null?"null":f, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(uids==null?"null":"" + uids, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(songs==null?"null":"" + songs, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(lis_01==null?"null":"" + lis_01, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(lis_02==null?"null":"" + lis_02, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(lis_03==null?"null":"" + lis_03, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(lis_04==null?"null":"" + lis_04, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(lis_05==null?"null":"" + lis_05, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(lis_06==null?"null":"" + lis_06, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(lis_07==null?"null":"" + lis_07, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(lis_08==null?"null":"" + lis_08, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(lis_09==null?"null":"" + lis_09, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(lis_10==null?"null":"" + lis_10, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(lis_11==null?"null":"" + lis_11, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(lis_12==null?"null":"" + lis_12, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(lis_13==null?"null":"" + lis_13, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(lis_14==null?"null":"" + lis_14, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(lis_15==null?"null":"" + lis_15, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(lis_16_19==null?"null":"" + lis_16_19, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(lis_20_29==null?"null":"" + lis_20_29, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(lis_30_39==null?"null":"" + lis_30_39, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(lis_40==null?"null":"" + lis_40, delimiters));
    if (useRecordDelim) {
      __sb.append(delimiters.getLinesTerminatedBy());
    }
    return __sb.toString();
  }
  private final DelimiterSet __inputDelimiters = new DelimiterSet((char) 1, (char) 10, (char) 0, (char) 0, false);
  private RecordParser __parser;
  public void parse(Text __record) throws RecordParser.ParseError {
    if (null == this.__parser) {
      this.__parser = new RecordParser(__inputDelimiters);
    }
    List<String> __fields = this.__parser.parseRecord(__record);
    __loadFromFields(__fields);
  }

  public void parse(CharSequence __record) throws RecordParser.ParseError {
    if (null == this.__parser) {
      this.__parser = new RecordParser(__inputDelimiters);
    }
    List<String> __fields = this.__parser.parseRecord(__record);
    __loadFromFields(__fields);
  }

  public void parse(byte [] __record) throws RecordParser.ParseError {
    if (null == this.__parser) {
      this.__parser = new RecordParser(__inputDelimiters);
    }
    List<String> __fields = this.__parser.parseRecord(__record);
    __loadFromFields(__fields);
  }

  public void parse(char [] __record) throws RecordParser.ParseError {
    if (null == this.__parser) {
      this.__parser = new RecordParser(__inputDelimiters);
    }
    List<String> __fields = this.__parser.parseRecord(__record);
    __loadFromFields(__fields);
  }

  public void parse(ByteBuffer __record) throws RecordParser.ParseError {
    if (null == this.__parser) {
      this.__parser = new RecordParser(__inputDelimiters);
    }
    List<String> __fields = this.__parser.parseRecord(__record);
    __loadFromFields(__fields);
  }

  public void parse(CharBuffer __record) throws RecordParser.ParseError {
    if (null == this.__parser) {
      this.__parser = new RecordParser(__inputDelimiters);
    }
    List<String> __fields = this.__parser.parseRecord(__record);
    __loadFromFields(__fields);
  }

  private void __loadFromFields(List<String> fields) {
    Iterator<String> __it = fields.listIterator();
    String __cur_str;
    __cur_str = __it.next();
    if (__cur_str.equals("null")) { this.f = null; } else {
      this.f = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.uids = null; } else {
      this.uids = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.songs = null; } else {
      this.songs = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.lis_01 = null; } else {
      this.lis_01 = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.lis_02 = null; } else {
      this.lis_02 = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.lis_03 = null; } else {
      this.lis_03 = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.lis_04 = null; } else {
      this.lis_04 = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.lis_05 = null; } else {
      this.lis_05 = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.lis_06 = null; } else {
      this.lis_06 = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.lis_07 = null; } else {
      this.lis_07 = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.lis_08 = null; } else {
      this.lis_08 = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.lis_09 = null; } else {
      this.lis_09 = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.lis_10 = null; } else {
      this.lis_10 = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.lis_11 = null; } else {
      this.lis_11 = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.lis_12 = null; } else {
      this.lis_12 = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.lis_13 = null; } else {
      this.lis_13 = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.lis_14 = null; } else {
      this.lis_14 = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.lis_15 = null; } else {
      this.lis_15 = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.lis_16_19 = null; } else {
      this.lis_16_19 = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.lis_20_29 = null; } else {
      this.lis_20_29 = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.lis_30_39 = null; } else {
      this.lis_30_39 = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.lis_40 = null; } else {
      this.lis_40 = Integer.valueOf(__cur_str);
    }

  }

  public Object clone() throws CloneNotSupportedException {
    ttpod_song_f o = (ttpod_song_f) super.clone();
    return o;
  }

  public Map<String, Object> getFieldMap() {
    Map<String, Object> __sqoop$field_map = new TreeMap<String, Object>();
    __sqoop$field_map.put("f", this.f);
    __sqoop$field_map.put("uids", this.uids);
    __sqoop$field_map.put("songs", this.songs);
    __sqoop$field_map.put("lis_01", this.lis_01);
    __sqoop$field_map.put("lis_02", this.lis_02);
    __sqoop$field_map.put("lis_03", this.lis_03);
    __sqoop$field_map.put("lis_04", this.lis_04);
    __sqoop$field_map.put("lis_05", this.lis_05);
    __sqoop$field_map.put("lis_06", this.lis_06);
    __sqoop$field_map.put("lis_07", this.lis_07);
    __sqoop$field_map.put("lis_08", this.lis_08);
    __sqoop$field_map.put("lis_09", this.lis_09);
    __sqoop$field_map.put("lis_10", this.lis_10);
    __sqoop$field_map.put("lis_11", this.lis_11);
    __sqoop$field_map.put("lis_12", this.lis_12);
    __sqoop$field_map.put("lis_13", this.lis_13);
    __sqoop$field_map.put("lis_14", this.lis_14);
    __sqoop$field_map.put("lis_15", this.lis_15);
    __sqoop$field_map.put("lis_16_19", this.lis_16_19);
    __sqoop$field_map.put("lis_20_29", this.lis_20_29);
    __sqoop$field_map.put("lis_30_39", this.lis_30_39);
    __sqoop$field_map.put("lis_40", this.lis_40);
    return __sqoop$field_map;
  }

  public void setField(String __fieldName, Object __fieldVal) {
    if ("f".equals(__fieldName)) {
      this.f = (String) __fieldVal;
    }
    else    if ("uids".equals(__fieldName)) {
      this.uids = (Integer) __fieldVal;
    }
    else    if ("songs".equals(__fieldName)) {
      this.songs = (Integer) __fieldVal;
    }
    else    if ("lis_01".equals(__fieldName)) {
      this.lis_01 = (Integer) __fieldVal;
    }
    else    if ("lis_02".equals(__fieldName)) {
      this.lis_02 = (Integer) __fieldVal;
    }
    else    if ("lis_03".equals(__fieldName)) {
      this.lis_03 = (Integer) __fieldVal;
    }
    else    if ("lis_04".equals(__fieldName)) {
      this.lis_04 = (Integer) __fieldVal;
    }
    else    if ("lis_05".equals(__fieldName)) {
      this.lis_05 = (Integer) __fieldVal;
    }
    else    if ("lis_06".equals(__fieldName)) {
      this.lis_06 = (Integer) __fieldVal;
    }
    else    if ("lis_07".equals(__fieldName)) {
      this.lis_07 = (Integer) __fieldVal;
    }
    else    if ("lis_08".equals(__fieldName)) {
      this.lis_08 = (Integer) __fieldVal;
    }
    else    if ("lis_09".equals(__fieldName)) {
      this.lis_09 = (Integer) __fieldVal;
    }
    else    if ("lis_10".equals(__fieldName)) {
      this.lis_10 = (Integer) __fieldVal;
    }
    else    if ("lis_11".equals(__fieldName)) {
      this.lis_11 = (Integer) __fieldVal;
    }
    else    if ("lis_12".equals(__fieldName)) {
      this.lis_12 = (Integer) __fieldVal;
    }
    else    if ("lis_13".equals(__fieldName)) {
      this.lis_13 = (Integer) __fieldVal;
    }
    else    if ("lis_14".equals(__fieldName)) {
      this.lis_14 = (Integer) __fieldVal;
    }
    else    if ("lis_15".equals(__fieldName)) {
      this.lis_15 = (Integer) __fieldVal;
    }
    else    if ("lis_16_19".equals(__fieldName)) {
      this.lis_16_19 = (Integer) __fieldVal;
    }
    else    if ("lis_20_29".equals(__fieldName)) {
      this.lis_20_29 = (Integer) __fieldVal;
    }
    else    if ("lis_30_39".equals(__fieldName)) {
      this.lis_30_39 = (Integer) __fieldVal;
    }
    else    if ("lis_40".equals(__fieldName)) {
      this.lis_40 = (Integer) __fieldVal;
    }
    else {
      throw new RuntimeException("No such field: " + __fieldName);
    }
  }
}
