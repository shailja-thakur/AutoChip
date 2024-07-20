module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);
    reg [2:0] state, next_state;

    // State Encoding
    localparam S000 = 3'b000;
    localparam S001 = 3'b001;
    localparam S010 = 3'b010;
    localparam S011 = 3'b011;
    localparam S100 = 3'b100;

    // State Transition Logic
    always @(*) begin
        case (state)
            S000: if (x == 0) next_state = S000; else next_state = S001;
            S001: if (x == 0) next_state = S001; else next_state = S100;
            S010: if (x == 0) next_state = S010; else next_state = S001;
            S011: if (x == 0) next_state = S001; else next_state = S010;
            S100: if (x == 0) next_state = S011; else next_state = S100;
            default: next_state = S000;
        endcase
    end

    // Output Logic for Y0 and z
    always @(*) begin
        case (next_state)
            S000: begin Y0 = 1'b0; z = 1'b0; end
            S001: begin Y0 = 1'b1; z = 1'b0; end
            S010: begin Y0 = 1'b0; z = 1'b0; end
            S011: begin Y0 = 1'b1; z = 1'b1; end
            S100: begin Y0 = 1'b0; z = 1'b1; end
            default: begin Y0 = 1'b0; z = 1'b0; end
        endcase
    end

    // State Update on Clock Edge
    always @(posedge clk) begin
        state <= next_state;
    end

endmodule
