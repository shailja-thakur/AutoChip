module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

// Define the states
parameter A = 1'b0;
parameter B = 1'b1;

// Define the internal state variable
reg state;

// Initialize the state
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
    end else begin
        state <= state;
    end
end

// FSM transitions and output logic
always @(posedge clk) begin
    case(state)
        A: begin
            if (s == 1'b1) begin
                state <= B;
            end else begin
                state <= A;
            end
        end
        B: begin
            if (w == 1'b1 && ((w+w+w) == 3'b010 || (w+w+w) == 3'b001 || (w+w+w) == 3'b100)) begin
                z <= 1'b1;
            end else begin
                z <= 1'b0;
            end
            state <= A;
        end
        default: state <= A;
    endcase
end

endmodule
