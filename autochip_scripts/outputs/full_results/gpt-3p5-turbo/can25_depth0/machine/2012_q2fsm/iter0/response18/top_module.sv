module top_module (
    input wire clk,
    input wire reset,
    input wire w,
    output wire z
);

    reg [2:0] state;  // state register

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 3'b000;  // initial state is A
        else begin
            case ({state, w})
                // state transitions when w is 0
                2'b00: state <= 3'b000;  // A -> A
                2'b01: state <= 3'b101;  // B -> D
                2'b10: state <= 3'b101;  // C -> D
                2'b11: state <= 3'b000;  // D -> A
                // state transitions when w is 1
                2'b01: state <= 3'b010;  // A -> B
                2'b10: state <= 3'b011;  // B -> C
                2'b11: state <= 3'b110;  // C -> E
                2'b00: state <= 3'b111;  // D -> F
                2'b11: state <= 3'b110;  // E -> E
                2'b10: state <= 3'b011;  // F -> C
            endcase
        end
    end

    // set output z to 1 when state is E or F
    assign z = (state == 3'b110) || (state == 3'b111);

endmodule
