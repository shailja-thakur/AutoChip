module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

    reg [1:0] state;
    reg [1:0] next_state;

    always @(posedge clk) begin
        if (!resetn) begin
            state <= 2'b00; // set state to A
        end else begin
            state <= next_state; // update state to next state
        end
    end

    always @(state or r) begin
        case (state)
            2'b00: begin // state A
                if (r[1]) begin
                    next_state = 2'b01; // set next state to B
                end else if (r[2]) begin
                    next_state = 2'b10; // set next state to C
                end else if (r[3]) begin
                    next_state = 2'b11; // set next state to D
                end else begin
                    next_state = 2'b00; // set next state to A
                end
            end
            2'b01: begin // state B
                if (r[1]) begin
                    next_state = 2'b01; // set next state to B
                end else begin
                    next_state = 2'b00; // set next state to A
                end
            end
            2'b10: begin // state C
                if (r[2]) begin
                    next_state = 2'b10; // set next state to C
                end else begin
                    next_state = 2'b00; // set next state to A
                end
            end
            2'b11: begin // state D
                if (r[3]) begin
                    next_state = 2'b11; // set next state to D
                end else begin
                    next_state = 2'b00; // set next state to A
                end
            end
        endcase
    end

    assign g[1] = (state == 2'b01) ? 1'b1 : 1'b0; // set g[1] high if state is B
    assign g[2] = (state == 2'b10) ? 1'b1 : 1'b0; // set g[2] high if state is C
    assign g[3] = (state == 2'b11) ? 1'b1 : 1'b0; // set g[3] high if state is D
endmodule
