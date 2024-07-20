module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

// States
localparam A = 1'b0;
localparam B = 1'b1;

// State register
reg state;

always @(posedge clk) begin
    if (reset) begin
        state <= B;
    end
    else begin
        case (state)
            A: begin
                if (in) begin
                    state <= A;
                end
                else begin
                    state <= B;
                end
            end
            B: begin
                if (in) begin
                    state <= B;
                end
                else begin
                    state <= A;
                end
            end
        endcase
    end
end

// Output logic
always @* begin
    case (state)
        A: out = 1'b0;
        B: out = 1'b1;
    endcase
end

endmodule
