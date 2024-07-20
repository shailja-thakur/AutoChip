module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

    reg [3:1] state;
    reg [3:1] next_state;

    always @(posedge clk) begin
        if (!resetn) begin
            state <= 3'b001; // Setting initial state to A
        end else begin
            state <= next_state; // Updating state register with next_state value
        end
    end

    always @* begin
        case (state)
            3'b001: begin // A state
                if (r[1]) begin
                    next_state = 3'b010; // Next state is B if r[1] is high
                end else if (r[2]) begin
                    next_state = 3'b011; // Next state is C if r[2] is high
                end else if (r[3]) begin
                    next_state = 3'b100; // Next state is D if r[3] is high
                end else begin
                    next_state = 3'b001; // Next state is A if none of the bits of r are high
                end
            end

            3'b010: begin // B state
                if (r[1]) begin
                    next_state = 3'b010; // Next state is B if r[1] is high
                end else begin
                    next_state = 3'b001; // Next state is A if r[1] is low
                end
            end

            3'b011: begin // C state
                if (r[2]) begin
                    next_state = 3'b011; // Next state is C if r[2] is high
                end else begin
                    next_state = 3'b001; // Next state is A if r[2] is low
                end
            end

            3'b100: begin // D state
                if (r[3]) begin
                    next_state = 3'b100; // Next state is D if r[3] is high
                end else begin
                    next_state = 3'b001; // Next state is A if r[3] is low
                end
            end
        endcase
    end

    assign g[1] = (state == 3'b010) ? 1'b1 : 1'b0; // Setting g[1] high if current state is B
    assign g[2] = (state == 3'b011) ? 1'b1 : 1'b0; // Setting g[2] high if current state is C
    assign g[3] = (state == 3'b100) ? 1'b1 : 1'b0; // Setting g[3] high if current state is D
endmodule
