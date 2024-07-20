module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    reg [2:0] state;

    // Your code here

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b001; // Initialize state to A
            z <= 1'b0; // Initialize output to low
        end else begin
            case (state)
                3'b000: begin // A
                    if (x) begin // x is high
                        state <= 3'b001; // Next state is B
                    end else begin // x is low
                        state <= 3'b000; // Next state is A
                    end
                end
                3'b001: begin // B
                    if (x) begin // x is high
                        state <= 3'b100; // Next state is E
                    end else begin // x is low
                        state <= 3'b001; // Next state is B
                    end
                end
                3'b010: begin // C
                    if (x) begin // x is high
                        state <= 3'b001; // Next state is B
                    end else begin // x is low
                        state <= 3'b010; // Next state is C
                    end
                end
                3'b011: begin // D
                    if (x) begin // x is high
                        state <= 3'b010; // Next state is C
                    end else begin // x is low
                        state <= 3'b001; // Next state is B
                    end
                end
                3'b100: begin // E
                    if (x) begin // x is high
                        state <= 3'b100; // Next state is E
                    end else begin // x is low
                        state <= 3'b011; // Next state is D
                    end
                end
                default: state <= 3'b001; // Default state is B
            endcase
        end
    end

    always @(state) begin
        if (state == 3'b100 || state == 3'b101) begin // D or E
            z <= 1'b1; // Output is high
        end else begin
            z <= 1'b0; // Output is low
        end
    end

endmodule
