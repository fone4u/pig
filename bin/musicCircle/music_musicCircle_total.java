// ORM class for table 'music_musicCircle_total'
// WARNING: This class is AUTO-GENERATED. Modify at your own risk.
//
// Debug information:
// Generated date: Thu Jun 20 22:13:21 CST 2013
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

public class music_musicCircle_total extends SqoopRecord  implements DBWritable, Writable {
  private final int PROTOCOL_VERSION = 3;
  public int getClassFormatVersion() { return PROTOCOL_VERSION; }
  protected ResultSet __cur_result_set;
  private String label;
  public String get_label() {
    return label;
  }
  public void set_label(String label) {
    this.label = label;
  }
  public music_musicCircle_total with_label(String label) {
    this.label = label;
    return this;
  }
  private Double pv;
  public Double get_pv() {
    return pv;
  }
  public void set_pv(Double pv) {
    this.pv = pv;
  }
  public music_musicCircle_total with_pv(Double pv) {
    this.pv = pv;
    return this;
  }
  private Integer uv;
  public Integer get_uv() {
    return uv;
  }
  public void set_uv(Integer uv) {
    this.uv = uv;
  }
  public music_musicCircle_total with_uv(Integer uv) {
    this.uv = uv;
    return this;
  }
  private java.sql.Date stat_date;
  public java.sql.Date get_stat_date() {
    return stat_date;
  }
  public void set_stat_date(java.sql.Date stat_date) {
    this.stat_date = stat_date;
  }
  public music_musicCircle_total with_stat_date(java.sql.Date stat_date) {
    this.stat_date = stat_date;
    return this;
  }
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof music_musicCircle_total)) {
      return false;
    }
    music_musicCircle_total that = (music_musicCircle_total) o;
    boolean equal = true;
    equal = equal && (this.label == null ? that.label == null : this.label.equals(that.label));
    equal = equal && (this.pv == null ? that.pv == null : this.pv.equals(that.pv));
    equal = equal && (this.uv == null ? that.uv == null : this.uv.equals(that.uv));
    equal = equal && (this.stat_date == null ? that.stat_date == null : this.stat_date.equals(that.stat_date));
    return equal;
  }
  public void readFields(ResultSet __dbResults) throws SQLException {
    this.__cur_result_set = __dbResults;
    this.label = JdbcWritableBridge.readString(1, __dbResults);
    this.pv = JdbcWritableBridge.readDouble(2, __dbResults);
    this.uv = JdbcWritableBridge.readInteger(3, __dbResults);
    this.stat_date = JdbcWritableBridge.readDate(4, __dbResults);
  }
  public void loadLargeObjects(LargeObjectLoader __loader)
      throws SQLException, IOException, InterruptedException {
  }
  public void write(PreparedStatement __dbStmt) throws SQLException {
    write(__dbStmt, 0);
  }

  public int write(PreparedStatement __dbStmt, int __off) throws SQLException {
    JdbcWritableBridge.writeString(label, 1 + __off, 12, __dbStmt);
    JdbcWritableBridge.writeDouble(pv, 2 + __off, 8, __dbStmt);
    JdbcWritableBridge.writeInteger(uv, 3 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeDate(stat_date, 4 + __off, 91, __dbStmt);
    return 4;
  }
  public void readFields(DataInput __dataIn) throws IOException {
    if (__dataIn.readBoolean()) { 
        this.label = null;
    } else {
    this.label = Text.readString(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.pv = null;
    } else {
    this.pv = Double.valueOf(__dataIn.readDouble());
    }
    if (__dataIn.readBoolean()) { 
        this.uv = null;
    } else {
    this.uv = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.stat_date = null;
    } else {
    this.stat_date = new Date(__dataIn.readLong());
    }
  }
  public void write(DataOutput __dataOut) throws IOException {
    if (null == this.label) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, label);
    }
    if (null == this.pv) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeDouble(this.pv);
    }
    if (null == this.uv) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.uv);
    }
    if (null == this.stat_date) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeLong(this.stat_date.getTime());
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
    __sb.append(FieldFormatter.escapeAndEnclose(label==null?"null":label, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(pv==null?"null":"" + pv, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(uv==null?"null":"" + uv, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(stat_date==null?"null":"" + stat_date, delimiters));
    if (useRecordDelim) {
      __sb.append(delimiters.getLinesTerminatedBy());
    }
    return __sb.toString();
  }
  private final DelimiterSet __inputDelimiters = new DelimiterSet((char) 44, (char) 10, (char) 0, (char) 0, false);
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
    if (__cur_str.equals("null")) { this.label = null; } else {
      this.label = __cur_str;
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.pv = null; } else {
      this.pv = Double.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.uv = null; } else {
      this.uv = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("null") || __cur_str.length() == 0) { this.stat_date = null; } else {
      this.stat_date = java.sql.Date.valueOf(__cur_str);
    }

  }

  public Object clone() throws CloneNotSupportedException {
    music_musicCircle_total o = (music_musicCircle_total) super.clone();
    o.stat_date = (o.stat_date != null) ? (java.sql.Date) o.stat_date.clone() : null;
    return o;
  }

  public Map<String, Object> getFieldMap() {
    Map<String, Object> __sqoop$field_map = new TreeMap<String, Object>();
    __sqoop$field_map.put("label", this.label);
    __sqoop$field_map.put("pv", this.pv);
    __sqoop$field_map.put("uv", this.uv);
    __sqoop$field_map.put("stat_date", this.stat_date);
    return __sqoop$field_map;
  }

  public void setField(String __fieldName, Object __fieldVal) {
    if ("label".equals(__fieldName)) {
      this.label = (String) __fieldVal;
    }
    else    if ("pv".equals(__fieldName)) {
      this.pv = (Double) __fieldVal;
    }
    else    if ("uv".equals(__fieldName)) {
      this.uv = (Integer) __fieldVal;
    }
    else    if ("stat_date".equals(__fieldName)) {
      this.stat_date = (java.sql.Date) __fieldVal;
    }
    else {
      throw new RuntimeException("No such field: " + __fieldName);
    }
  }
}
