module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    reg [1:0] state;  // Define a 2-bit register for the state
    always @(posedge clk or posedge reset) begin
        if (reset) begin  // Check if reset is active
            state <= 2'b10;  // set initial state to B
        end else begin
            case (state)  // Perform state transition based on the current state
                2'b10: begin  // Current state is B
                    if (in) begin  // Check the input
                        state <= 2'b10;  // Next state is B
                    end else begin
                        state <= 2'b01;  // Next state is A
                    end
                end
                2'b01: begin  // Current state is A
                    if (in) begin  // Check the input
                        state <= 2'b01;  // Next state is A
                    end else begin
                        state <= 2'b10;  // Next state is B
                    end
                end
                default: state <= 2'b10;  // Set default state to B
            endcase
        end
    end
    
    assign out = (state == 2'b01) ? 1'b0 : 1'b1;  // Set output based on current state
    
endmodule
