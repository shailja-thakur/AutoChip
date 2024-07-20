module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

    reg [3:1] state;
    reg [3:1] next_state;

    always @(posedge clk) begin
        if (resetn == 0) begin
            state <= 3'b001; // A
        end else begin
            state <= next_state;
        end
    end

    always @* begin
        case (state)
            3'b001: begin // A
                if (r[1]) begin
                    next_state = 3'b010; // B
                end else if (r[2]) begin
                    next_state = 3'b011; // C
                end else if (r[3]) begin
                    next_state = 3'b100; // D
                end else begin
                    next_state = 3'b001; // A
                end
            end
            3'b010: begin // B
                if (r[1]) begin
                    next_state = 3'b010; // B
                end else begin
                    next_state = 3'b001; // A
                end
            end
            3'b011: begin // C
                if (r[2]) begin
                    next_state = 3'b011; // C
                end else begin
                    next_state = 3'b001; // A
                end
            end
            3'b100: begin // D
                if (r[3]) begin
                    next_state = 3'b100; // D
                end else begin
                    next_state = 3'b001; // A
                end
            end
            default: begin
                next_state = 3'b001; // A
            end
        endcase
    end

    assign g[1] = (state == 3'b010); // B
    assign g[2] = (state == 3'b011); // C
    assign g[3] = (state == 3'b100); // D

endmodule
