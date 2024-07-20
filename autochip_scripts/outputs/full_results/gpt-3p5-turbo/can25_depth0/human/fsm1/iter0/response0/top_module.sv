module top_module (
    input clk,
    input in,
    input areset,
    output out
);

reg [1:0] state;
reg out_next;

// Enumeration for states
parameter B = 2'b00;
parameter A = 2'b01;

// Initial state assignment
initial begin
    if (areset)
        state <= B;
    else
        state <= A;
end

// Next state and output logic
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= B;
    else begin
        case(state)
            B: begin
                if (in)
                    state <= B;
                else
                    state <= A;
            end
            A: begin
                if (in)
                    state <= A;
                else
                    state <= B;
            end
            default: state <= B;
        endcase
    end
end

// Output assignment
always @(state) begin
    case(state)
        B: out_next = 1'b1;
        A: out_next = 1'b0;
        default: out_next = 1'b0;
    endcase
end

assign out = out_next;

endmodule
