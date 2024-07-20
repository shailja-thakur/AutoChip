module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);
    
    parameter IDLE = 2'b00;
    parameter START_BIT = 2'b01;
    parameter DATA_BIT = 2'b10;
    parameter STOP_BIT = 2'b11;
    
    reg [1:0] state;
    reg [7:0] data_byte;
    reg done;
    
    // Synchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            data_byte <= 8'b0;
            done <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (in == 1'b0) begin
                        state <= START_BIT;
                        data_byte <= 8'b0;
                        done <= 0;
                    end
                end
                
                START_BIT: begin
                    state <= DATA_BIT;
                    data_byte <= 8'b0;
                    done <= 0;
                end
                
                DATA_BIT: begin
                    if (in == 1'b0) begin
                        data_byte <= {data_byte[6:0], in};
                    end else begin
                        state <= STOP_BIT;
                        done <= 0;
                    end
                end
                
                STOP_BIT: begin
                    if (in == 1'b1) begin
                        state <= IDLE;
                        out_byte <= data_byte;
                        done <= 1;
                    end
                end
            endcase
        end
    end
    
endmodule
