module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

    reg [3:1] state;
    reg [3:1] next_state;

    always @(posedge clk) begin
        if (!resetn)
            state <= 3'b001; // state A
        else
            state <= next_state;
    end

    always @(state or r) begin
        case (state)
            3'b001: begin // state A
                if (r[1])
                    next_state = 3'b010; // state B
                else if (r[2])
                    next_state = 3'b011; // state C
                else if (r[3])
                    next_state = 3'b100; // state D
                else
                    next_state = 3'b001; // state A
            end
            3'b010: begin // state B
                if (r[1])
                    next_state = 3'b010; // state B
                else
                    next_state = 3'b001; // state A
            end
            3'b011: begin // state C
                if (r[2])
                    next_state = 3'b011; // state C
                else
                    next_state = 3'b001; // state A
            end
            3'b100: begin // state D
                if (r[3])
                    next_state = 3'b100; // state D
                else
                    next_state = 3'b001; // state A
            end
        endcase
    end

    assign g[1] = (state == 3'b010) ? 1'b1 : 1'b0; // current state is B
    assign g[2] = (state == 3'b011) ? 1'b1 : 1'b0; // current state is C
    assign g[3] = (state == 3'b100) ? 1'b1 : 1'b0; // current state is D

endmodule
