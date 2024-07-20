module top_module (
    input clk,
    input in,
    input reset,
    output done
);

    // Define states
    parameter IDLE = 2'b00;
    parameter START_BIT = 2'b01;
    parameter DATA_BITS = 2'b10;
    parameter STOP_BIT = 2'b11;
    
    // Define internal signals
    reg [1:0] state;
    reg [7:0] data;
    reg done;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            data <= 8'b0;
            done <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (in == 1'b0) begin
                        state <= START_BIT;
                    end
                end
                START_BIT: begin
                    state <= DATA_BITS;
                    data <= 8'b0;
                end
                DATA_BITS: begin
                    if (in == 1'b1) begin
                        data <= {in, data[7:1]};
                    end
                    if ($countones(data) == 8) begin
                        state <= STOP_BIT;
                    end
                end
                STOP_BIT: begin
                    if (in == 1'b1) begin
                        state <= IDLE;
                        done <= 1;
                    end
                end
            endcase
        end
    end
    
endmodule
