module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state;
reg [2:0] w_count; // Counter to keep track of w values
reg w_prev;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b00; // reset state A
        w_count <= 3'b000;
        w_prev <= 1'b0;
    end else begin
        case (state)
            2'b00: begin // state A
                if (s) begin
                    state <= 2'b01; // move to state B
                end
            end
            2'b01: begin // state B
                if (w_count == 3'b000) begin
                    if (w != w_prev) begin
                        w_count <= 3'b001; // Increment counter
                    end
                end else if (w_count == 3'b111) begin
                    state <= 2'b10; // transition to next state
                    w_count <= 3'b000; // Reset counter
                end else begin
                    if (w != w_prev) begin
                        w_count <= w_count + 1; // Increment counter
                    end
                end
            end
            2'b10: begin // check w for 3 cycles
                if (w_count == 3'b111) begin
                    if (w != w_prev) begin
                        state <= 2'b11;
                        w_count <= 3'b000; // Reset counter
                    end
                end else begin
                    if (w != w_prev) begin
                        w_count <= w_count + 1; // Increment counter
                    end
                end
            end
            2'b11: begin // check w for 3 cycles
                if (w_count == 3'b111) begin
                    if (w != w_prev) begin
                        state <= 2'b00;
                        w_count <= 3'b000; // Reset counter
                    end
                end else begin
                    if (w != w_prev) begin
                        w_count <= w_count + 1; // Increment counter
                    end
                end
            end
        endcase
        w_prev <= w; // Store current w value
    end
end

always @(posedge clk) begin
    if (state == 2'b11) begin
        if (w_count[2] == 1 && w_count[1] == 1) begin
            z <= 1;
        end else begin
            z <= 0;
        end
    end else begin
        z <= 0;
    end
end

endmodule
