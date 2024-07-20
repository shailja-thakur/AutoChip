module arbiter_fsm (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

    // State variables
    reg [1:0] state_reg;
    reg [1:0] state_next;


    // State codes
    localparam A = 2'b00;
    localparam B = 2'b01;
    localparam C = 2'b10;
    localparam D = 2'b11;


    // Output assignments
    always @* begin
        // Default values
        g = 3'b000;

        case(state_reg)
            A: begin
                if (r[1] && r[2] && r[3])
                    g = 3'b000;
                else if (r[1])
                    g[1] = 1'b1;
                else if (r[2])
                    g[2] = 1'b1;
                else if (r[3])
                    g[3] = 1'b1;
            end
            
            B: begin
                if (r[1] && r[2] && r[3] && g[1])
                    g[1] = 1'b1;
                else if (r[1])
                    g[1] = 1'b1;
            end

            C: begin
                if (r[1] && r[2] && r[3] && g[2])
                    g[2] = 1'b1;
                else if (r[2])
                    g[2] = 1'b1;
            end
        endcase
    end


    // State transition logic
    always @(posedge clk or negedge resetn) begin
        if (~resetn)
            state_reg <= A;
        else
            state_reg <= state_next;
    end

    always @* begin
        // Default next state
        state_next = state_reg;

        case(state_reg)
            A: begin
                if (r[1] && ~r[2] && ~r[3])
                    state_next = B;
                else if (~r[1] && r[2] && ~r[3])
                    state_next = C;
                else if (~r[1] && ~r[2] && ~r[3])
                    state_next = D;
            end

            B: begin
                if (~r[1] && r[2] && ~r[3])
                    state_next = A;
            end

            C: begin
                if (~r[1] && ~r[2] && ~r[3])
                    state_next = A;
            end

            D: begin
                if (r[1] && r[2] && r[3])
                    state_next = A;
            end
        endcase
    end

endmodule
module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

    arbiter_fsm fsm (
        .clk(clk),
        .resetn(resetn),
        .r(r),
        .g(g)
    );

endmodule
