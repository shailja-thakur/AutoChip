module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);
    reg [3:1] state;
    reg [3:1] next;

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= 3'b001; // state A
        end else begin
            state <= next;
        end
    end

    always @(state or r) begin
        case (state)
            3'b001: begin // state A
                if (r[1]) begin
                    next = 3'b010; // state B
                end else if (r[2]) begin
                    next = 3'b011; // state C
                end else if (r[3]) begin
                    next = 3'b100; // state D
                end else begin
                    next = 3'b001; // state A
                end
            end

            3'b010: begin // state B
                if (r[1]) begin
                    next = 3'b010; // state B
                end else begin
                    next = 3'b001; // state A
                end
            end

            3'b011: begin // state C
                if (r[2]) begin
                    next = 3'b011; // state C
                end else begin
                    next = 3'b001; // state A
                end
            end

            3'b100: begin // state D
                if (r[3]) begin
                    next = 3'b100; // state D
                end else begin
                    next = 3'b001; // state A
                end
            end
        endcase
    end

    assign g[3] = (state == 3'b010); // g[1] is high when state is B
    assign g[2] = (state == 3'b011); // g[2] is high when state is C
    assign g[1] = (state == 3'b100); // g[3] is high when state is D
    assign g[0] = 3'b000; // all other bits of g are low
endmodule
