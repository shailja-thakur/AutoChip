module top_module (
    input clk,
    input in,
    input reset,
    output out
);

// Define the states
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

// Define the state register
reg [1:0] state_reg;
reg [1:0] state_next;

// Initialize the state register
always @(posedge clk) begin
    if (reset) begin
        state_reg <= A;
    end else begin
        state_reg <= state_next;
    end
end

// Define the state transition logic
always @(state_reg or in) begin
    case (state_reg)
        A: begin
            if (in) begin
                state_next = B;
            end else begin
                state_next = A;
            end
        end
        B: begin
            if (in) begin
                state_next = B;
            end else begin
                state_next = C;
            end
        end
        C: begin
            if (in) begin
                state_next = D;
            end else begin
                state_next = A;
            end
        end
        D: begin
            if (in) begin
                state_next = B;
            end else begin
                state_next = C;
            end
        end
    endcase
end

// Define the output logic
assign out = (state_reg == D) ? 1'b1 : 1'b0;

endmodule
