module top_module (
    input clk,
    input in,
    input areset,
    output out
);

// Define the states
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

// Define the state register and next state variables
reg [1:0] state;
reg [1:0] next_state;

// Define the output register
reg out_reg;

// Assign default values
assign out = out_reg;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        // Asynchronous reset, reset state to A
        state <= A;
    end else begin
        // Synchronous updates
        state <= next_state;
    end
end

always @(*) begin
    // State transition and output logic
    case(state)
        A: begin
            if (in) begin
                next_state = B;
                out_reg = 0;
            end else begin
                next_state = A;
                out_reg = 0;
            end
        end
        B: begin
            if (in) begin
                next_state = B;
                out_reg = 0;
            end else begin
                next_state = C;
                out_reg = 0;
            end
        end
        C: begin
            if (in) begin
                next_state = D;
                out_reg = 0;
            end else begin
                next_state = A;
                out_reg = 0;
            end
        end
        D: begin
            if (in) begin
                next_state = B;
                out_reg = 1;
            end else begin
                next_state = C;
                out_reg = 1;
            end
        end
    endcase
end

endmodule
