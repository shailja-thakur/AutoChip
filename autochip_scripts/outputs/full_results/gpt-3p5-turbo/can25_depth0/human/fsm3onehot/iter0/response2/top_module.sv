module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output reg out
);

always @(*) begin
    case(state)
        4'b0001: begin
            if(in)
                next_state = 4'b0010; // B
            else
                next_state = 4'b0001; // A
            out = 1'b0;
        end
        4'b0010: begin
           if(in)
              next_state = 4'b0010; // B
           else
              next_state = 4'b0100; // C
           out = 1'b0;
        end
        4'b0100: begin
           if(in)
              next_state = 4'b0001; // A
           else
              next_state = 4'b1000; // D
           out = 1'b0;
        end
        4'b1000: begin
          if(in)
              next_state = 4'b0100; // C
          else
              next_state = 4'b0010; // B
          out = 1'b1;
        end
        default: begin
            next_state = 4'b0000; // Error state
            out = 1'b0;
        end
    endcase
end

endmodule
