module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);
    reg [2:0] state, next_state;

    // State Transition Logic
    always @(posedge clk) begin
        state <= next_state;
    end

    always @(*) begin
        case (state)
            3'b000: begin
                next_state = (x == 1'b0) ? 3'b000 : 3'b001;
                z = 1'b0;
            end
            
            3'b001: begin
                next_state = (x == 1'b0) ? 3'b001 : 3'b100;
                z = 1'b0;
            end

            3'b010: begin
                next_state = (x == 1'b0) ? 3'b010 : 3'b001;
                z = 1'b0;
            end

            3'b011: begin
                next_state = (x == 1'b0) ? 3'b001 : 3'b010;
                z = 1'b1;
            end

            3'b100: begin
                next_state = (x == 1'b0) ? 3'b011 : 3'b100;
                z = 1'b1;
            end

            default: begin
                next_state = 3'b000;
                z = 1'b0;
            end
        endcase
    end

    // Output Y0 Logic
    always @(*) begin
        Y0 = next_state[0];
    end
endmodule
