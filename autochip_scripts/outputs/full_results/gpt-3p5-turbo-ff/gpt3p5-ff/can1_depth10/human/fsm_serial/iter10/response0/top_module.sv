module top_module (
    input wire clk,
    input wire in,
    input wire reset,
    output reg done
);

    reg [2:0] state;
    reg [7:0] data;
    reg [7:0] expected_data;
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
                    expected_data <= 8'b0;
                end
                
                3'b010: begin // data bit state
                    data <= {data[6:0], in}; // shift in received bit
                    if (in == 1'b1) begin
                        expected_data <= {data[7:1], 1'b1};
                    else
                        expected_data <= {data[7:1], 1'b0};
                    end
                    if (expected_data == 8'b11111111) begin
                        state <= 3'b011; // transition to stop bit state
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
                    state <= 3'b000; // transition to idle state
                    done <= 1'b0;
                    stop_error <= 1'b0;
                end
            endcase
        end
    end
    
endmodule
