module top_module (
    input clk,
    input reset,
    input w,
    output z
);

reg [2:0] state;
reg [2:0] next_state;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b010;  // initial state B

    else
        state <= next_state;
end

always @(state or w) begin
    case (state)

    3'b010: begin  // state B
        if (w)
            next_state = 3'b100;  // next state E
        else
            next_state = 3'b001;  // next state A
    end

    3'b100: begin  // state E
        if (w)
            next_state = 3'b100;  // next state E
        else
            next_state = 3'b011;  // next state D
    end

    3'b011: begin  // state D
        if (w)
            next_state = 3'b110;  // next state F
        else
            next_state = 3'b000;  // next state A
    end

    3'b110: begin  // state F
        if (w)
            next_state = 3'b010;  // next state C
        else
            next_state = 3'b011;  // next state D
    end

    3'b001: begin  // state A
        if (w)
            next_state = 3'b010;  // next state C
        else
            next_state = 3'b000;  // next state A
    end

    3'b000: begin  // state C
        if (w)
            next_state = 3'b100;  // next state E
        else
            next_state = 3'b011;  // next state D
    end

    default: next_state = 3'b010;  // default to state B
    endcase
end

assign z = (state == 3'b100);  // output z when in state E

endmodule
