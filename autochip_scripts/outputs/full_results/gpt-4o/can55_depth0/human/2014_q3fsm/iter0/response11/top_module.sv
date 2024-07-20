module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State encoding
    localparam A = 2'b00, B = 2'b01, C1 = 2'b10, C2 = 2'b11;

    reg [1:0] state, next_state;
    reg [1:0] w_count;

    // Sequential logic for state transitions
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            w_count <= 2'd0;
            z <= 1'b0;
        end else begin
            state <= next_state;
        end
    end

    // Combinational logic for next state
    always @(*) begin
        next_state = state;
        case (state)
            A: begin
                if (s)
                    next_state = B;
            end
            B: begin
                next_state = C1;
                w_count = (w ? 1 : 0);
                z = 1'b0;
            end
            C1: begin
                if (w) w_count = w_count + 1;
                next_state = C2;
            end
            C2: begin
                if (w) w_count = w_count + 1;
                
                // Check the number of 1's counted
                if (w_count == 2'b10) begin
                    z = 1'b1;
                end else begin
                    z = 1'b0;
                end

                next_state = B;  // Repeat the process every 3 clock cycles
            end
        endcase
    end

endmodule
