module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);
    reg [7:0] received_data;
    reg [2:0] state;
    reg [2:0] next_state;
    reg start_bit_detected;
  
    // Internal signals
    wire stop_bit_detected = (state == 3'b100) ? 1'b1 : 1'b0;
  
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
            start_bit_detected <= 1'b0;
            received_data <= 8'b0;
            out_byte <= 8'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            start_bit_detected <= (state == 3'b001) ? in : 1'b0;
            received_data <= (state == 3'b100) ? {received_data[6:0], in} : received_data;
        end
    end
  
    always @* begin
        case (state)
            3'b000: begin // Idle state
                next_state = (start_bit_detected) ? 3'b001 : 3'b000;
            end
            3'b001: begin // Receiving data bits
                next_state = (state == 3'b111) ? 3'b100 : {state[1:0], 1'b0};
            end
            3'b100: begin // Waiting for stop bit
                next_state = (stop_bit_detected) ? 3'b000 : 3'b100;
            end
            default: next_state = 3'b000;
        endcase
    end
    
    always @(posedge clk) begin
        if (done) begin
            out_byte <= received_data;
        end
    end
endmodule
