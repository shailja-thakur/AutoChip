module top_module (
    input clk,
    input in,
    input areset,
    output out
);

// Define the state machine states
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

// Define the state register
reg [1:0] state;
reg out;

// Logic for next state and output
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A;
    end else begin
        case (state)
            A: begin
                if (in) begin
                    state <= B;
                end else begin
                    state <= A;
                end
            end
            B: begin
                if (in) begin
                    state <= B;
                end else begin
                    state <= C;
                end
            end
            C: begin
                if (in) begin
                    state <= D;
                end else begin
                    state <= A;
                end
            end
            D: begin
                if (in) begin
                    state <= B;
                end else begin
                    state <= C;
                end
            end
            default: state <= A;
        endcase
    end
end

// Logic for output
always @(state) begin
    if (state == D) begin
        out <= 1;
    end else begin
        out <= 0;
    end
end

endmodule
