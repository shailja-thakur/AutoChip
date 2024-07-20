module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

// Define state codes
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

// Define state register
reg [1:0] state;

// Define output registers
reg [3:1] g_reg;

// State flip-flop
always @(posedge clk or negedge resetn) begin
    if (!resetn)
        state <= A;
    else begin
        case (state)
            A: begin
                if (r[1])
                    state <= B;
                else if (r[2])
                    state <= C;
                else if (r[3])
                    state <= D;
            end
            B: begin
                if (r[1])
                    state <= B;
                else
                    state <= A;
            end
            C: begin
                if (r[2])
                    state <= C;
                else
                    state <= A;
            end
            D: begin
                if (r[1] || r[2] || r[3])
                    state <= D;
                else
                    state <= A;
            end
        endcase
    end
end

// Output assignments
always @(state) begin
    case (state)
        A: g_reg <= 3'b000;
        B: g_reg <= {2'b01, r[1]};
        C: g_reg <= {2'b10, r[2]};
        D: g_reg <= {2'b00, r[3]};
    endcase
end

// Assign outputs
assign g = g_reg;

endmodule
