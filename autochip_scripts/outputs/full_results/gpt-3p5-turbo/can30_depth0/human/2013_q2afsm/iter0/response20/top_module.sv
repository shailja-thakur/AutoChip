module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

    reg [3:1] state;
    reg [3:1] next_state;

    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            state <= 3'b001;  // Initial state A
        end else begin
            state <= next_state;
        end
    end

    always @(state, r) begin
        case(state)
            3'b001: begin
                if (r[1]) begin
                    next_state = 3'b010;  // Transition to state B
                end else if (r[2]) begin
                    next_state = 3'b011;  // Transition to state C
                end else if (r[3]) begin
                    next_state = 3'b100;  // Transition to state D
                end else begin
                    next_state = 3'b001;  // Stay in state A
                end
            end

            3'b010: begin
                if (r[1]) begin
                    next_state = 3'b010;  // Stay in state B
                end else begin
                    next_state = 3'b001;  // Transition to state A
                end
            end

            3'b011: begin
                if (r[2]) begin
                    next_state = 3'b011;  // Stay in state C
                end else begin
                    next_state = 3'b001;  // Transition to state A
                end
            end

            3'b100: begin
                next_state = 3'b001;  // Transition to state A
            end
        endcase
    end

    assign g[1] = (state == 3'b010);
    assign g[2] = (state == 3'b011);
    assign g[3] = (state == 3'b100);

endmodule
