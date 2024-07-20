module top_module(
  input wire clk,
  input wire reset,
  input wire data,
  output wire [3:0] count,
  output reg counting,
  output reg done,
  input wire ack 
);

reg [3:0] delay;
reg [2:0] state;

always @(posedge clk or posedge reset) begin
  if(reset) begin
    delay <= 0;
    state <= 0;
    counting <= 0;
    done <= 0;
  end
  else begin
    case(state)
      0: begin // Idle state
           if(data == 1) begin
             state <= 1;
           end
           else begin
             state <= 0;
           end
         end
         
      1: begin // Check for 1
           if(data == 1) begin
             state <= 2;
           end
           else begin
             state <= 0;
           end
         end
         
      2: begin // Check for 1
           if(data == 0) begin
             state <= 3;
           end
           else begin
             state <= 0;
           end
         end
         
      3: begin // Check for 0
           if(data == 1) begin
             state <= 0;
             delay <= {data, delay[3:1]};
             counting <= 1;
           end
           else begin
             state <= 0;
           end
         end
         
      default: state <= 0; // Reset to idle state
    endcase
  end
  
  if(counting) begin
    if(count == 0) begin
      counting <= 0;
      done <= 1;
    end
    else begin
      count <= count - 1;
    end
  end
  
end

assign count = delay;
endmodule
