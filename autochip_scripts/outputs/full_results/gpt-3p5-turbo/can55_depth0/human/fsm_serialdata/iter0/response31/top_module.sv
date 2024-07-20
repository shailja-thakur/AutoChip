module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);
    
    reg [2:0] state;
    reg [7:0] data_byte;
    reg start_bit_detected;
    reg stop_bit_detected;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000;
            out_byte <= 8'b0;
            done <= 1'b0;
            start_bit_detected <= 1'b0;
            stop_bit_detected <= 1'b0;
        end else begin
            case (state)
                3'b000: // IDLE state
                    if (in) begin
                        state <= 3'b001; // Move to the START state
                    end
                3'b001: // START state
                    if (~in) begin
                        state <= 3'b010; // Move to the RECEIVING state
                        start_bit_detected <= 1'b1;
                    end
                3'b010: // RECEIVING state
                    if (stop_bit_detected) begin
                        state <= 3'b011; // Move to the DONE state
                        done <= 1'b1;
                        out_byte <= data_byte;
                    end else if (start_bit_detected && ~in) begin
                        state <= 3'b100; // Move to the ERROR state
                    end else if (start_bit_detected) begin
                        data_byte <= {data_byte[6:0], in}; // Shift in the data bit
                    end
                3'b011: // DONE state
                    if (~in) begin
                        state <= 3'b100; // Move to the ERROR state
                    end else if (start_bit_detected && ~in) begin
                        state <= 3'b001; // Move to the START state
                        start_bit_detected <= 1'b0;
                        stop_bit_detected <= 1'b0;
                    end
                3'b100: // ERROR state
                    if (start_bit_detected && ~in) begin
                        state <= 3'b001; // Move to the START state
                        start_bit_detected <= 1'b0;
                        stop_bit_detected <= 1'b0;
                    end
            endcase
        end
    end
    
    always @(posedge clk) begin
        if (reset) begin
            start_bit_detected <= 1'b0;
            stop_bit_detected <= 1'b0;
        end else begin
            if (state == 3'b001 || state == 3'b100) begin // START state or ERROR state
                start_bit_detected <= in;
                stop_bit_detected <= 1'b0;
            end else if (state == 3'b010) begin // RECEIVING state
                start_bit_detected <= 1'b0;
                stop_bit_detected <= in;
            end else if (state == 3'b011) begin // DONE state
                start_bit_detected <= 1'b0;
                stop_bit_detected <= 1'b0;
            end
        end
    end
    
endmodule
