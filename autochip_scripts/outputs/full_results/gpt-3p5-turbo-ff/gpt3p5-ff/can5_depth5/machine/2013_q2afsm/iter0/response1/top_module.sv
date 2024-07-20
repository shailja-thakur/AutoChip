module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

    reg [2:0] state;
    reg [2:0] next_state;

    always @(posedge clk) begin
        if (!resetn) begin
            state <= 3'b001; // A
        end else begin
            state <= next_state;
        end
    end

    always @* begin
        case (state)
            3'b001: // A
                if (r[1]) begin
                    next_state = 3'b010; // B
                end else if (r[2]) begin
                    next_state = 3'b011; // C
                end else if (r[3]) begin
                    next_state = 3'b100; // D
                end else begin
                    next_state = 3'b001; // A
                end
            3'b010: // B
                if (r[1]) begin
                    next_state = 3'b010; // B
                end else begin
                    next_state = 3'b001; // A
                end
            3'b011: // C
                if (r[2]) begin
                    next_state = 3'b011; // C
                end else begin
                    next_state = 3'b001; // A
                end
            3'b100: // D
                if (r[3]) begin
                    next_state = 3'b100; // D
                end else begin
                    next_state = 3'b001; // A
                end
            default:
                next_state = 3'b001; // A
        endcase
    end

    assign g[1] = (state == 3'b010) ? 1'b1 : 1'b0;
    assign g[2] = (state == 3'b011) ? 1'b1 : 1'b0;
    assign g[3] = (state == 3'b100) ? 1'b1 : 1'b0;

endmodule
