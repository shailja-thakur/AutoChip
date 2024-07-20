module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    reg [2:0] state;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b001;  // Initialize state to A
        end else begin
            case (state)
                3'b000: begin // State A
                    if (x) begin
                        state <= 3'b010;  // Next state is B
                    end else begin
                        state <= 3'b000;  // Next state is A
                    end
                end
                3'b001: begin // State B
                    if (x) begin
                        state <= 3'b100;  // Next state is E
                    end else begin
                        state <= 3'b001;  // Next state is B
                    end
                end
                3'b010: begin // State C
                    if (x) begin
                        state <= 3'b001;  // Next state is B
                    end else begin
                        state <= 3'b010;  // Next state is C
                    end
                end
                3'b011: begin // State D
                    if (x) begin
                        state <= 3'b010;  // Next state is C
                    end else begin
                        state <= 3'b010;  // Next state is B
                    end
                end
                3'b100: begin // State E
                    if (x) begin
                        state <= 3'b100;  // Next state is E
                    end else begin
                        state <= 3'b011;  // Next state is D
                    end
                end
                default: begin
                    state <= 3'b000;  // Default initialization
                end
            endcase
        end
    end
    
    always @(state) begin
        if (state == 3'b100 || state == 3'b101) begin
            z <= 1'b1;  // Output is high when state is D or E
        end else begin
            z <= 1'b0;
        end
    end
        
endmodule
