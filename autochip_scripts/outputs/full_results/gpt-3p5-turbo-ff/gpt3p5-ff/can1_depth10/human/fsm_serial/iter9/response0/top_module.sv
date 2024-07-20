module top_module (
    input wire clk,
    input wire in,
    input wire reset,
    output reg done
);

    reg [2:0] state;
    reg last_bit;
    reg [7:0] data;
    reg stop_error;
    reg stop_bit;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
            data <= 8'b0;
            stop_error <= 1'b0;
            done <= 1'b0;
            stop_bit <= 1'b0;
        end else begin
            case (state)
                3'b000: begin // idle state
                    if (in == 1'b0) begin
                        state <= 3'b001; // transition to start bit state
                    end
                end
                
                3'b001: begin // start bit state
                    state <= 3'b010; // transition to data bit state
                    data <= 8'b0;
                    last_bit <= in;
                end
                
                3'b010: begin // data bit state
                    data <= {data[6:0], in}; // shift in received bit
                    if (in == 1'b1) begin
                        last_bit <= in;
                    end else begin
                        state <= 3'b011; // transition to stop bit state
                        stop_error <= 1'b1;
                        stop_bit <= in;
                    end
                end
                
                3'b011: begin // stop bit state
                    if (in == 1'b1 && stop_bit == 1'b1) begin
                        state <= 3'b000; // transition to idle state
                        done <= 1'b1; // byte received successfully
                        stop_error <= 1'b0;
                    end else begin
                        state <= 3'b100; // transition to error state
                        stop_error <= 1'b1; // incorrect stop bit
                    end
                end
                
                3'b100: begin // error state
                    if (in == 1'b0) begin
                        state <= 3'b000; // transition to idle state
                    end
                    stop_error <= 1'b0;
                end
            endcase
        end
    end
    
endmodule
