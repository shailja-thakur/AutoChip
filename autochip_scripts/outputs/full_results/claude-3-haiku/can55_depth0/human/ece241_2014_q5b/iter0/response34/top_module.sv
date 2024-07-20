module top_module (
    input clk,
    input areset,
    input x,
    output z
);

// One-hot encoding for the states
parameter A = 2'b01, B = 2'b10;

// State register
reg [1:0] state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A;
    end
    else begin
        case (state)
            A: begin
                if (x) begin
                    state <= B;
                end
                else begin
                    state <= A;
                end
            end
            B: begin
                if (x) begin
                    state <= B;
                end
                else begin
                    state <= B;
                end
            end
            default: state <= A;
        endcase
    end
end

// Output logic
assign z = (state == B) ? x : ~x;

endmodule
