module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

reg [3:0] state;
reg [3:0] next_state;
wire sequence_found;

// Define the sequence 1101
parameter S0 = 4'b0000;
parameter S1 = 4'b0001;
parameter S2 = 4'b0010;
parameter S3 = 4'b0011;
parameter SF = 4'b0100; // Sequence Found

// Set initial state and next_state based on state transitions
always @ (state, data) begin
    case (state)
        S0: begin
            next_state = data ? S1 : S0;
        end
        S1: begin
            next_state = data ? S2 : S0;
        end
        S2: begin
            next_state = data ? S3 : S0;
        end
        S3: begin
            next_state = data ? S1 : SF;
        end
        SF: begin
            next_state = reset ? S0 : SF;
        end
    endcase
end

// Synchronous state update
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= S0;
        start_shifting <= 0;
    end else begin
        state <= next_state;
        start_shifting <= (state == SF);
    end
end

endmodule
