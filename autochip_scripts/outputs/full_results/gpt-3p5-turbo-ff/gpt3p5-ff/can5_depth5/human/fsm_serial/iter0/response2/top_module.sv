module top_module (
    input clk,
    input in,
    input reset,
    output done
);

reg [2:0] state;
reg [7:0] data;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 3'b000;
        data <= 8'b0;
    end else begin
        case (state)
            3'b000: begin // Idle state
                if (in == 1'b0) begin
                    state <= 3'b001; // Start bit detected, move to next state
                    data <= 8'b0;
                end
            end
            3'b001: begin // Receive data bits
                data <= {data[6:0], in};
                state <= 3'b010;
            end
            3'b010: begin // Wait for all data bits to be received
                data <= {data[6:0], in};
                if (data[7] == 1'b1) begin
                    state <= 3'b011; // Stop bit detected, move to next state
                end
            end
            3'b011: begin // Verify stop bit and signal done
                if (in == 1'b1) begin
                    done <= 1'b1; // Byte received successfully
                end else begin
                    done <= 1'b0; // Incorrect stop bit, wait for next stop bit
                    state <= 3'b000;
                end
            end
            default: state <= 3'b000;
        endcase
    end
end

endmodule
