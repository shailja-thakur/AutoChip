module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state;
reg [2:0] next_state;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b000;  // initial state A
    else
        state <= next_state;
end

always @(state or w) begin
    case (state)
    3'b000: begin // state A
        if (w)
            next_state = 3'b001; // next state B
        else
            next_state = 3'b000; // next state A
    end

    3'b001: begin // state B
        if (w)
            next_state = 3'b010; // next state C
        else
            next_state = 3'b011; // next state D
    end

    3'b010: begin // state C
        if (w)
            next_state = 3'b100; // next state E
        else
            next_state = 3'b011; // next state D
    end

    3'b011: begin // state D
        if (w)
            next_state = 3'b110; // next state F
        else
            next_state = 3'b000; // next state A
    end

    3'b100: begin // state E
        if (w)
            next_state = 3'b100; // next state E
        else
            next_state = 3'b011; // next state D
    end

    3'b110: begin // state F
        if (w)
            next_state = 3'b010; // next state C
        else
            next_state = 3'b011; // next state D
    end

    default: next_state = 3'b000; // default to state A
    endcase
end

always @(posedge clk) begin
    if (reset)
        z <= 1'b0;
    else if (state == 3'b100) // output z when in state E
        z <= 1'b1;
    else
        z <= 1'b0;
end

endmodule
