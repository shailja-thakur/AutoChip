module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

    reg [3:1] state;
    reg [3:1] next_state;

    parameter A = 3'b001;
    parameter B = 3'b010;
    parameter C = 3'b011;
    parameter D = 3'b100;

    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end
    
    always @* begin
        // Default outputs
        g = 3'b000;

        case(state)
            A: begin
                if (r[1] == 1) begin
                    next_state = B;
                end else if (r[2] == 1) begin
                    next_state = C;
                end else if (r[1] == 0 && r[2] == 0 && r[3] == 0) begin
                    next_state = D;
                end else begin
                    next_state = A;
                end
            end

            B: begin
                if (r[1] == 1) begin
                    next_state = B;
                    g[1] = 1;
                end else begin
                    next_state = A;
                end
            end

            C: begin
                if (r[2] == 1) begin
                    next_state = C;
                    g[2] = 1;
                end else begin
                    next_state = A;
                end
            end

            D: begin
                if (r[1] == 0 && r[2] == 0 && r[3] == 0) begin
                    next_state = D;
                end else begin
                    next_state = A;
                end
            end
        endcase
    end

endmodule
