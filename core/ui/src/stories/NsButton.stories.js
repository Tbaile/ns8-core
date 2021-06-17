import NsButton from "../components/NsButton.vue";
import Save from "@carbon/icons-vue/es/save/20";

export default {
  title: "Components/NsButton",
  component: NsButton,
  argTypes: {
    kind: {
      options: [
        "default",
        "primary",
        "secondary",
        "tertiary",
        "ghost",
        "danger",
        "danger--ghost",
        "danger--tertiary",
      ],
      control: { type: "select" },
    },
    size: {
      options: ["default", "field", "small", "sm", "lg", "xl"],
      control: { type: "select" },
    },
  },
};

const Template = (args, { argTypes }) => ({
  props: Object.keys(argTypes),
  components: { NsButton },
  template: '<NsButton v-bind="$props">I am a button</NsButton>',
});

export const Default = Template.bind({});
Default.args = {
  kind: "default",
};

export const Icon = Template.bind({});
Icon.args = {
  kind: "default",
  icon: Save,
};