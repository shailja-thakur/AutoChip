module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

reg [2:0] state;
reg [7:0] data_byte;
reg stop_bit_detected;

// State definitions
parameter IDLE = 3'b000;
parameter START_BIT = 3'b001;
parameter DATA_BITS = 3'b010;
parameter STOP_BIT_WAIT = 3'b011;
parameter STOP_BIT_DETECT = 3'b100;

// Next state and output logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        data_byte <= 8'b0;
        stop_bit_detected <= 1'b0;
        out_byte <= 8'b0;
        done <= 1'b0;
    end else begin
        case(state)
            IDLE: begin
                     if (in == 1'b0) begin
                         state <= START_BIT;
                     end
                 end
            START_BIT: begin
                           state <= DATA_BITS;
                       end
            DATA_BITS: begin
                          if (in == 1'b0) begin
                              data_byte <= {data_byte[6:0], in};
                          end
                          
                          if ( |data_byte == 8'b1111111 && in == 1'b1) begin
                              state <= STOP_BIT_WAIT;
                          end
                      end
            STOP_BIT_WAIT: begin
                              if (in == 1'b1) begin
                                  state <= STOP_BIT_DETECT;
                              end
                          end
            STOP_BIT_DETECT: begin
                                 if (in == 1'b1) begin
                                     stop_bit_detected <= 1'b1;
                                 end
                                 
                                 if (stop_bit_detected) begin
                                     out_byte <= data_byte;
                                     done <= 1'b1;
                                     
                                     data_byte <= 8'b0;
                                     stop_bit_detected <= 1'b0;
                                     state <= START_BIT;
                                 end else begin
                                     state <= STOP_BIT_WAIT;
                                 end
                             end
        endcase
    end
end

endmodule
