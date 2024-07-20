module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State encoding
    parameter A = 2'b00, B = 2'b01, C = 2'b10;

    reg [1:0] state, next_state;
    reg [1:0] w_count;
    reg [1:0] cycle_count;

    // State register
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            w_count <= 2'b00;
            cycle_count <= 2'b00;
        end else begin
            state <= next_state;
            if (state == B) begin
                w_count <= (w_count + w);
                cycle_count <= (cycle_count + 2'b01);
            end else begin
                w_count <= 2'b00;
                cycle_count <= 2'b00;
            end
        end
    end

    // Output logic
    always @(*) begin
        z = 1'b0;
        case (state)
            A: begin
                if (s)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if (cycle_count == 2'b10) begin // After 3 clock cycles (2'd0 to 2'd2)
                    if (w_count == 2'b10) // Check if w was 1 exactly twice
                        z = 1'b1;
                    next_state = B; // Continue in state B
                end else
                    next_state = B;
            end
            default: next_state = A;
        endcase
    end

endmodule
