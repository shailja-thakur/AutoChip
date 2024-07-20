module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

reg [3:0] state;

// Define state values
parameter START = 0;
parameter SHIFT_ENA = 1;
parameter COUNTING = 2;
parameter DONE = 3;

always @(posedge clk) begin
    if (reset) begin
        state <= START; // Reset state
        shift_ena <= 0; // Reset shift enable output
        counting <= 0; // Reset counting output
        done <= 0; // Reset done output
    end else begin
        case (state)
            START: begin
                if (data == 4'b1101) begin
                    state <= SHIFT_ENA; // Move to shift enable state
                    shift_ena <= 1; // Assert shift enable output
                end
            end
            SHIFT_ENA: begin
                state <= COUNTING; // Move to counting state
                shift_ena <= 0; // Deassert shift enable output
                counting <= 1; // Assert counting output
            end
            COUNTING: begin
                if (done_counting) begin
                    state <= DONE; // Move to done state
                    counting <= 0; // Deassert counting output
                    done <= 1; // Assert done output
                end
            end
            DONE: begin
                if (ack) begin
                    state <= START; // Reset state
                    done <= 0; // Deassert done output
                end
            end
        endcase
    end
end

endmodule
